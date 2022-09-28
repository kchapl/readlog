module Web.View.Books.New where
import Web.View.Prelude

data NewView = NewView { book :: Book }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Book</h1>
        {renderForm book}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Books" BooksAction
                , breadcrumbText "New Book"
                ]

renderForm :: Book -> Html
renderForm book = formFor book [hsx|
    {(textField #author)}
    {(textField #title)}
    {(textField #subtitle)}
    {(textField #publicationYear)}
    {(textField #publicationPlace)}
    {(textField #publisher)}
    {(textField #isbn)}
    {submitButton}

|]