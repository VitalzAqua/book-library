import React, { useState, useEffect} from 'react'
import axios from 'axios'
import { useParams } from 'react-router-dom'

export function GetBook() {

    const [book, setBook] = useState({})

    let { _member_id} = useParams();
    let { _state} = useParams();
    useEffect(() => {

        axios.get('localhost:5000/getborrow/${_member_id}/${_state}')
        .then(res => {
            console.log(res.data.json)
            setBook(res.data.json)
        })
        .catch(err => {
            console.log(err)
        })
    })

    return (
        <div className="GetBook">
            <form>
            <label>
                Member_id:
                <input type="text" name="member_id" value={_member_id} onChange={_member_id} />
            </label>
            <label>
                State:
                <input type="text" name="state" value={_state} onChange={_state} />
            </label>
            <input type="submit" value="Submit"/>
            </form>
            <h1>Book</h1>
        </div>
    )
}

