module Web.View.Books.Index where
import Web.View.Prelude

data IndexView = IndexView { books :: [Book]  }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewBookFromIsbnAction} class="btn btn-primary ml-4">+ New ISBN</a> <a href={pathTo NewBookAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Book</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>   
                </thead>
                <tbody>{forEach books renderBook}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Books" BooksAction
                ]

renderBook :: Book -> Html
renderBook book = [hsx|
    <tr>
        <td>{book.author} ({book.publicationYear}) <em>{book.title}: {book.subtitle}</em>. {book.publicationPlace}: {book.publisher}.</td>
        <td><a href={ShowBookAction book.id}>Show</a></td>
        <td><a href={EditBookAction book.id} class="text-muted">Edit</a></td>
        <td><a href={DeleteBookAction book.id} class="js-delete text-muted">Delete</a></td>
    </tr>
|]