<!-- Part of the style come from Laravel Jetstream templates -->
@import basic.models.User
@import gg.jte.Content

@param Content content
@param User loggedUser = null

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Basic</title>
    <link rel="stylesheet" href="out.css">
</head>

<body class="font-sans antialiased">

    <div class="min-h-screen bg-gray-100">

        <!-- Page Heading -->
        @if (true)
        <header class="bg-white shadow flex">
            <div class="flex-1 max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
                @template.menu()
            </div>

            <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
                @template.account(loggedUser)
            </div>
        </header>
        @endif

        <!-- Page Content -->
        <main>
            <div class="py-4 sm:py-8">
                <div class="max-w-7xl mx-auto px-2 sm:px-6 lg:px-8">
                    ${content}
                </div>
            </div>
        </main>
    </div>
</body>

</html>