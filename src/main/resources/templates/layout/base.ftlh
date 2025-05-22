<#macro base title="">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><#if title??>${title}<#else>MicroForum</#if></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/main.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="/">MicroForum</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="/">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/messages">Messages</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/users/list">Users</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <#if currentUser??>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                <#if currentUser.avatarPath??>
                                    <img src="${currentUser.avatarPath}" alt="Avatar" class="avatar-sm rounded-circle me-1">
                                </#if>
                                ${currentUser.username}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="/users/profile">My Profile</a></li>
                                <li><a class="dropdown-item" href="/users/edit">Edit Profile</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <form action="/logout" method="post" class="d-inline">
                                        <button type="submit" class="dropdown-item">Logout</button>
                                    </form>
                                </li>
                            </ul>
                        </li>
                    <#else>
                        <li class="nav-item">
                            <a class="nav-link" href="/login">Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/register">Register</a>
                        </li>
                    </#if>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <#if successMessage??>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </#if>
        
        <#if errorMessage??>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </#if>

        <#nested>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/main.js"></script>
</body>
</html>
</#macro>
