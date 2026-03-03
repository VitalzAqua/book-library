import { Link, Route, Routes } from "react-router-dom"
import { GetBook } from "./components/GetBook"
import { Checkout } from "./components/Checkout"
import { RenewBooks } from "./components/RenewBooks"
import { NotFound } from "./components/NotFound"


function App () {
    return (
    <>
    <nav>
        <ul>
        <li>
            <Link to="/">GetBook</Link>
        </li>
        <li>
            <Link to="/checkout">Checkout</Link>
        </li>
        <li>
            <Link to="/renewbooks">RenewBooks</Link>
        </li>
        <li>
            <Link to="/notfound">NotFound</Link>
        </li>

        </ul>
    </nav>
    <Routes>
        <Route path="/" element={<GetBook />} />
        <Route path="/checkout" element={<Checkout />} />
        <Route path="/renewbooks" element={<RenewBooks />} />
        <Route path="*" element={<NotFound />} />
    </Routes>
    </>
    )
}


export default App;