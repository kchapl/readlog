module Web.View.Books.Show where
import Web.View.Prelude

data ShowView = ShowView { book :: Book }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Book</h1>
        <div>{book.author} ({book.publicationYear}) <em>{book.title}: {book.subtitle}</em>. {book.publicationPlace}: {book.publisher}. {book.isbn}</div>
    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Books" BooksAction
                            , breadcrumbText "Show Book"
                            ]