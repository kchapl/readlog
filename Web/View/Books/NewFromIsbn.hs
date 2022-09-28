module Web.View.Books.NewFromIsbn where
import Web.View.Prelude

data NewFromIsbnView = NewFromIsbnView { book :: Book }

instance View NewFromIsbnView where
    html NewFromIsbnView { .. } = [hsx|
        {breadcrumb}
        <h1>New ISBN</h1>
        {renderForm book}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Books" BooksAction
                , breadcrumbText "New ISBN"
                ]

renderForm :: Book -> Html
renderForm book = formFor' book (pathTo CreateBookFromIsbnAction) [hsx|
    {(textField #isbn)}
    {submitButton}

|]