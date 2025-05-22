<#import "layout/base.ftlh" as layout>

<@layout.base title="Users - MicroForum">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h4>Users</h4>
                </div>
                <div class="card-body">
                    <#if users?? && users?size gt 0>
                        <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
                            <#list users as user>
                                <div class="col">
                                    <div class="card h-100">
                                        <div class="card-body text-center">
                                            <#if user.avatarPath??>
                                                <img src="${user.avatarPath}" alt="Avatar" class="avatar-lg rounded-circle mb-3">
                                            <#else>
                                                <div class="avatar-lg rounded-circle bg-secondary text-white d-flex align-items-center justify-content-center mx-auto mb-3">
                                                    ${user.username?substring(0,1)?upper_case}
                                                </div>
                                            </#if>
                                            <h5 class="card-title">${user.username}</h5>
                                            <p class="card-text text-muted">Member since: ${user.createdAt.toString()}</p>
                                            <a href="/users/${user.id}" class="btn btn-primary btn-sm">View Profile</a>
                                        </div>
                                    </div>
                                </div>
                            </#list>
                        </div>
                    <#else>
                        <p class="text-center">No users found.</p>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</@layout.base>
