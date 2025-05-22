<#import "layout/base.ftlh" as layout>

<@layout.base title="Register - MicroForum">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h4 class="text-center">Register</h4>
                </div>
                <div class="card-body">
                    <#if errorMessage??>
                        <div class="alert alert-danger" role="alert">
                            ${errorMessage}
                        </div>
                    </#if>
                    <form action="/register" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <div class="mb-3">
                            <label for="bio" class="form-label">Bio (Optional)</label>
                            <textarea class="form-control" id="bio" name="bio" rows="3"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="avatar" class="form-label">Avatar (Optional)</label>
                            <input type="file" class="form-control" id="avatar" name="avatar" accept="image/*">
                        </div>
                        <!-- CSRF token is temporarily disabled for troubleshooting -->
                        <div class="d-grid">
                            <button type="submit" class="btn btn-success">Register</button>
                        </div>
                    </form>
                </div>
                <div class="card-footer text-center">
                    <p class="mb-0">Already have an account? <a href="/login">Login</a></p>
                </div>
            </div>
        </div>
    </div>
</@layout.base>
