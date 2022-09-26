module Web.View.Books.Show where
import Web.View.Prelude

data ShowView = ShowView { book :: Book }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Book</h1>
        <p>{book}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Books" BooksAction
                            , breadcrumbText "Show Book"
                            ]