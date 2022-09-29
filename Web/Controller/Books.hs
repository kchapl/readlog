module Web.Controller.Books where

import Web.Controller.Prelude
import Web.View.Books.Index
import Web.View.Books.New
import Web.View.Books.NewFromIsbn
import Web.View.Books.Edit
import Web.View.Books.Show

import qualified Network.Wreq as Wreq
import Control.Lens ((^.))

instance Controller BooksController where
    action BooksAction = do
        books <- query @Book |> fetch
        render IndexView { .. }

    action NewBookAction = do
        let book = newRecord
        render NewView { .. }

    action NewBookFromIsbnAction = do
        let book = newRecord
        render NewFromIsbnView { .. }

    action ShowBookAction { bookId } = do
        book <- fetch bookId
        render ShowView { .. }

    action EditBookAction { bookId } = do
        book <- fetch bookId
        render EditView { .. }

    action UpdateBookAction { bookId } = do
        book <- fetch bookId
        book
            |> buildBook
            |> ifValid \case
                Left book -> render EditView { .. }
                Right book -> do
                    book <- book |> updateRecord
                    setSuccessMessage "Book updated"
                    redirectTo EditBookAction { .. }

    action CreateBookAction = do
        let book = newRecord @Book
        book
            |> buildBook
            |> ifValid \case
                Left book -> render NewView { .. } 
                Right book -> do
                    book <- book |> createRecord
                    setSuccessMessage "Book created"
                    redirectTo BooksAction

    action CreateBookFromIsbnAction = do
        handleFetchAction "https://www.googleapis.com/books/v1/volumes?q=isbn:9780008241780"

    action DeleteBookAction { bookId } = do
        book <- fetch bookId
        deleteRecord book
        setSuccessMessage "Book deleted"
        redirectTo BooksAction

buildBook book = book
    |> fill @["author", "title", "subtitle", "publicationYear", "publicationPlace", "publisher", "isbn"]

buildBookFromIsbn isbn = isbn

handleFetchAction :: _ => Text -> _
handleFetchAction url = do
    documentBody <- do
        response <- Wreq.get (cs url)
        pure (response ^. Wreq.responseBody)
    renderPlain (cs documentBody)
