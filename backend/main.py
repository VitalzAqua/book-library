import pymysql
from backend.app import app
from flask import request, Response, abort, jsonify
from backend.config import mysql
from datetime import date
import random
from random import randint

current_year = date.today().year
class BorrowDetails:
    def __init__(self, borrow_id: int, library_id: int, copy_id: int, title: str, author_name: str, publication_year: int, borrowed_date: str) -> None:
        self._borrow_id = borrow_id
        self._library_id = library_id
        self._copy_id = copy_id
        self._title = title
        self._author_name = author_name
        self._publication_year = publication_year
        self._borrowed_date = borrowed_date
    
    def __str__(self) -> dict:
        new_dict = {
            "borrow_id": self._borrow_id, 
            "library_id": self._library_id, 
            "copy_id": self._copy_id,
            "title": self._title,
            "author_name": self._author_name,
            "publication_year": self._publication_year,
            "borrowed_date": self._borrowed_date
        }
        return f"{self._borrow_id}"

class Book:
    def __init__(self, title: str, genre: str, author_name: str, publication_year: str, library_id: int, copies: int) -> None:
        self._title = title
        self._genre = genre
        self._author_name = author_name
        self._publication_year = publication_year
        self._library_id = library_id
        self._copies = copies

class Borrow:
    def __init__(self, borrow_id: int, returned_date: date, times_renewed: int) -> None:
        self._borrow_id = borrow_id
        self._returned_date = returned_date
        self._times_renewed = times_renewed

class Checkout:
    def __init__(self, title: str, author_name: str, member_id: int, library_id: int, book_copy_id: int) -> None:
        self._title = title
        self._author_name = author_name
        self._member_id = member_id
        self._library_id = library_id
        self._book_copy_id = book_copy_id
    

@app.route('/getborrow/<int:_member_id>/<string:_state>')
def borrow_details(_member_id: int, _state: str):
    if not isinstance(_member_id, int) or len(str(_member_id)) != 6 or not isinstance(_state, str):
        abort(400)
    if _state.lower() != "active" and _state.lower() != "history":
        abort(400)
    else:
        try:
            conn = mysql.connect()
            cursor = conn.cursor()
            if _state == "active":
                cursor.callproc('get_borrowed_books_active', [_member_id])
                result = cursor.fetchall()
            elif _state == "history":
                cursor.callproc('get_borrowed_books_history', [_member_id])
                result = cursor.fetchall()
        except:
            abort(500)
        if str(result) == "()":
            abort(404)
        else:
            borrowdetails = []
            for row in result:
                # borrowdetails.append(BorrowDetails(row[0], row[1], row[2], row[3], row[4], row[5], row[6]))
                borrowdetails.append({"borrow_id":row[0],"library_id":row[1],"copy_id":row[2],"title":row[3],"author_name":row[4],"publication_year":row[5],"borrowed_date":str(row[6])})
            cursor.close() 
            conn.close() 
            return f"{borrowdetails}"

@app.route('/checkout', methods=['POST', 'PUT'])
def checkout():
    _checkout_json = request.json
    if len(_checkout_json) != 3 or not isinstance(_checkout_json["title"], str) or not isinstance(_checkout_json["author_name"], str) or not isinstance(_checkout_json["member_id"], int) or len(_checkout_json["title"]) > 30 or len(_checkout_json["author_name"]) > 30 or len(str(_checkout_json["member_id"])) != 6:
        abort(400)
    else:
        checkout = Checkout(_checkout_json["title"].lower(), _checkout_json["author_name"].lower(), _checkout_json["member_id"], None, None)
        try:
            conn = mysql.connect()
            cursor = conn.cursor()
        except:
            abort(500)
        sqlQuery0 = "SELECT book_info_id FROM book_info WHERE title = (%s) AND author_name = (%s)"
        bindData0 = (checkout._title, checkout._author_name)
        x = cursor.execute(sqlQuery0, bindData0)
        if x < 1:
            abort(404)
        else:
            y = cursor.execute("SELECT member_id FROM member WHERE member_id = (%s)" % (checkout._member_id))
            if  y < 1:
                abort(404)
            else:
                try:
                    cursor.callproc('checkout_book', [checkout._title, checkout._author_name])
                except:
                    abort(500)
                result = cursor.fetchall()
                for row in result:
                    checkout._library_id = row[0]
                    checkout._book_copy_id = row[1]
                
                sqlQuery = "INSERT INTO borrow(library_id, member_id, book_copy_id, borrowed_date, returned_date, times_renewed) VALUES(%s, %s, %s, %s, %s, %s)"
                bindData = (checkout._library_id, checkout._member_id, checkout._book_copy_id, date.today(), None, 0)
                cursor.execute(sqlQuery, bindData)
                conn.commit()

                cursor.execute("UPDATE book_copy SET status = 'B' WHERE book_copy_id = (%s)" % (checkout._book_copy_id))
                conn.commit()
                cursor.closse()
                conn.close()
                return f"Successfully checked out {checkout._title}, book_copy #: {checkout._book_copy_id}"


@app.route('/createbook', methods=['POST'])
def create_book():
    _book_json = request.json
    if len(_book_json) != 6 or not isinstance(_book_json["title"], str) or not isinstance(_book_json["genre"], str) or not isinstance(_book_json["author_name"], str) or not isinstance(_book_json["publication_year"], int) or not isinstance(_book_json["library_id"], int) or not isinstance(_book_json["copies"], int) or not _book_json["copies"] > 0 or not _book_json["copies"] < 100:
        abort(400)
    elif len(_book_json["title"]) > 30 or len(_book_json["genre"]) > 20 or len(_book_json["author_name"]) > 30 or _book_json["publication_year"] > current_year or _book_json["publication_year"] < 0 or len(str(_book_json["library_id"])) != 3:
        abort(400)
    else:
        book = Book(_book_json["title"].lower(), _book_json["genre"].lower(), _book_json["author_name"].lower(), _book_json["publication_year"], _book_json["library_id"], _book_json["copies"])
        try:
            conn = mysql.connect()
            cursor = conn.cursor()	
        except:
            abort(500)
        sqlQuery0 = "SELECT book_info_id FROM book_info WHERE title = (%s) AND author_name = (%s)"
        bindData0 = (book._title, book._author_name)
        x = cursor.execute(sqlQuery0, bindData0)
        if x > 0:
            abort(409)
        else:
            new_id_list = []
            new_lib_list = []
            cursor.execute("SELECT book_info_id FROM book_info")
            for row in cursor.fetchall():
                new_id_list.append(row[0])
            
            cursor.execute("SELECT library_id FROM library")
            for row in cursor.fetchall():
                new_lib_list.append(row[0])
        
            if book._library_id not in new_lib_list:
                abort(404)
            
            valid_input = False
            while valid_input == False:
                info_id = randint(10000, 99999)    
                if info_id not in new_id_list:
                    valid_input = True
                else:
                    pass
            
            
            sqlQuery = "INSERT INTO book_info(book_info_id, title, genre, author_name, publication_year) VALUES(%s, %s, %s, %s, %s)" 
            bindData = (info_id, book._title, book._genre, book._author_name, book._publication_year)            
            cursor.execute(sqlQuery, bindData)
            conn.commit()
            sqlQuery2 = "INSERT INTO book_copy(library_id, book_info_id, status) VALUES(%s, %s, %s)"
            bindData2 = (book._library_id, info_id, "A")
            for i in range(book._copies):
                cursor.execute(sqlQuery2, bindData2)
                conn.commit()
                cursor.close() 
                conn.close() 
                return f"{book._copies} copies of {book._title} added successfully"


@app.route('/updateborrow', methods=['PUT'])
def update_borrow():
    _borrow_json = request.json
    borrows = []
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
    except:
        abort(500)
        
    for id in _borrow_json:
        if not isinstance(id, int) or len(str(id)) != 4 or id < 5000:
            abort(400)
        else:
            borrows.append(Borrow(id, None, None))
            cursor.execute("SELECT returned_date, times_renewed FROM borrow WHERE borrow_id = (%s)" % (id))
            for row in cursor.fetchall():
                if row[0] != None:
                    abort(400)
                elif int(row[1]) == 3:
                    abort(403)
                else:
                    for borrow in borrows:
                        borrow._returned_date = row[0]
                        borrow._times_renewed = int(row[1])
                        cursor.execute("UPDATE borrow SET times_renewed = times_renewed + 1 WHERE borrow_id = (%s)" % (borrow._borrow_id))
                        conn.commit()
                        return f"Successfully renewed all renewable books"

                    
    
        
       

@app.errorhandler(400)
def error404(error):
    return Response('Invalid input', 400)

@app.errorhandler(409)
def error409(error):
    return Response('Record exits', 409)

@app.errorhandler(403)
def error403(error):
    return Response('Maximum Reached', 403)

@app.errorhandler(404)
def error404(error):
    return Response('Record not found', 404)

@app.errorhandler(500)
def error500(error):
    return Response('Internal server error', 500)

if __name__ == "__main__":
    app.run()

