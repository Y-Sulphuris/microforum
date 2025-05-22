<#import "layout/base.ftlh" as layout>

<@layout.base title="Home - MicroForum">
    <div class="row">
        <div class="col-md-8">
            <div class="card mb-4">
                <div class="card-header">
                    <h4>Recent Messages</h4>
                </div>
                <div class="card-body">
                    <#if messages?? && messages?size gt 0>
                        <div class="list-group">
                            <#list messages as message>
                                <a href="/messages/${message.id}" class="list-group-item list-group-item-action">
                                    <div class="d-flex w-100 justify-content-between">
                                        <h5 class="mb-1">${message.title!''}</h5>
<#--										.toString()-->
                                        <small><#if message.createdAt??>${message.createdAt.toString()}<#else>Unknown date</#if></small>
                                    </div>
                                    <p class="mb-1">${message.content?truncate(150)}</p>
                                    <small>
                                        Posted by: ${message.author.username}
                                        <#if message.replies?? && message.replies?size gt 0>
                                            | ${message.replies?size} replies
                                        </#if>
                                    </small>
                                </a>
                            </#list>
                        </div>
                    <#else>
                        <p class="text-center">No messages yet. Be the first to post!</p>
                    </#if>
                    
                    <div class="mt-3">
                        <a href="/messages" class="btn btn-primary">View All Messages</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-header">
                    <h4>Welcome to MicroForum</h4>
                </div>
                <div class="card-body">
                    <p>This is a simple forum application where you can:</p>
                    <ul>
                        <li>Create and reply to messages</li>
                        <li>Customize your profile</li>
                        <li>Post updates on your profile</li>
                    </ul>
                    <#if !currentUser??>
                        <div class="d-grid gap-2">
                            <a href="/register" class="btn btn-success">Register Now</a>
                            <a href="/login" class="btn btn-outline-primary">Login</a>
                        </div>
                    </#if>
                </div>
            </div>
            
            <#if currentUser??>
                <div class="card">
                    <div class="card-header">
                        <h4>Quick Links</h4>
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-2">
                            <a href="/messages" class="btn btn-outline-primary">Browse Messages</a>
                            <a href="/users/profile" class="btn btn-outline-info">View Your Profile</a>
                            <a href="/users/list" class="btn btn-outline-secondary">Browse Users</a>
                        </div>
                    </div>
                </div>
            </#if>
        </div>
    </div>
</@layout.base>
