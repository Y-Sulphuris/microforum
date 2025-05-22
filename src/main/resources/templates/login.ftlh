<#import "layout/base.ftlh" as layout>

<@layout.base title="Login - MicroForum">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h4 class="text-center">Login</h4>
                </div>
                <div class="card-body">
                    <#if RequestParameters.error??>
                        <div class="alert alert-danger" role="alert">
                            Invalid username or password
                        </div>
                    </#if>
                    <#if RequestParameters.logout??>
                        <div class="alert alert-success" role="alert">
                            You have been logged out
                        </div>
                    </#if>
                    <#if successMessage??>
                        <div class="alert alert-success" role="alert">
                            ${successMessage}
                        </div>
                    </#if>
                    <form action="/login" method="post">
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="remember-me" name="remember-me">
                            <label class="form-check-label" for="remember-me">Remember me</label>
                        </div>
                        <div class="d-grid">
<#--							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>-->
                            <button type="submit" class="btn btn-primary">Login</button>
                        </div>
                    </form>
                </div>
                <div class="card-footer text-center">
                    <p class="mb-0">Don't have an account? <a href="/register">Register</a></p>
                </div>
            </div>
        </div>
    </div>
</@layout.base>
