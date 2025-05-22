<#import "layout/base.ftlh" as layout>

<@layout.base title="${(message.title)!''} - MicroForum">
    <div class="row">
        <div class="col-md-9">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4>${(message.title)!''}</h4>
                    <small>${message.createdAt.toString()}</small>
                </div>
                <div class="card-body">
                    <div class="d-flex mb-3">
                        <div class="flex-shrink-0">
                            <#if message.author.avatarPath??>
                                <img src="${message.author.avatarPath}" alt="Avatar" class="avatar rounded-circle">
                            <#else>
                                <div class="avatar rounded-circle bg-secondary text-white d-flex align-items-center justify-content-center">
                                    ${message.author.username?substring(0,1)?upper_case}
                                </div>
                            </#if>
                        </div>
                        <div class="flex-grow-1 ms-3">
                            <h5 class="mt-0">
                                <a href="/users/${message.author.id}">${message.author.username}</a>
                            </h5>
                            <p class="message-content">${message.content}</p>
                            
                            <#if currentUser?? && currentUser.id == message.author.id>
                                <div class="btn-group">
                                    <a href="/messages/${message.id}/edit" class="btn btn-sm btn-outline-primary">Edit</a>
                                    <form action="/messages/${message.id}/delete" method="post" class="d-inline">
                                        <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure you want to delete this message?')">Delete</button>
                                    </form>
                                </div>
                            </#if>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-header">
                    <h5>Replies</h5>
                </div>
                <div class="card-body">
                    <#if replies?? && replies?size gt 0>
                        <div class="replies">
                            <#list replies as reply>
                                <div class="reply mb-4">
                                    <div class="d-flex">
                                        <div class="flex-shrink-0">
                                            <#if reply.author.avatarPath??>
                                                <img src="${reply.author.avatarPath}" alt="Avatar" class="avatar-sm rounded-circle">
                                            <#else>
                                                <div class="avatar-sm rounded-circle bg-secondary text-white d-flex align-items-center justify-content-center">
                                                    ${reply.author.username?substring(0,1)?upper_case}
                                                </div>
                                            </#if>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <h6 class="mt-0">
                                                    <a href="/users/${reply.author.id}">${reply.author.username}</a>
                                                </h6>
                                                <small>${reply.createdAt.toString()}</small>
                                            </div>
                                            <p>${reply.content}</p>
                                            
                                            <#if currentUser?? && currentUser.id == reply.author.id>
                                                <div class="btn-group">
                                                    <a href="/messages/${reply.id}/edit" class="btn btn-sm btn-outline-primary">Edit</a>
                                                    <form action="/messages/${reply.id}/delete" method="post" class="d-inline">
                                                        <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure you want to delete this reply?')">Delete</button>
                                                    </form>
                                                </div>
                                            </#if>
                                        </div>
                                    </div>
                                </div>
                                <hr>
                            </#list>
                        </div>
                    <#else>
                        <p class="text-center">No replies yet. Be the first to reply!</p>
                    </#if>
                </div>
            </div>

            <#if currentUser??>
                <div class="card">
                    <div class="card-header">
                        <h5>Add Reply</h5>
                    </div>
                    <div class="card-body">
                        <form action="/messages/${message.id}/reply" method="post">
                            <input type="hidden" name="title" value="Re: ${(message.title)!''}">
                            <input type="hidden" name="id" value="">
                            <div class="mb-3">
                                <textarea class="form-control" id="content" name="content" rows="3" required placeholder="Write your reply..."></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Post Reply</button>
                        </form>
                    </div>
                </div>
            <#else>
                <div class="alert alert-info">
                    <p>You need to <a href="/login">login</a> to reply to messages.</p>
                </div>
            </#if>
        </div>
        
        <div class="col-md-3">
            <div class="card sticky-top" style="top: 20px;">
                <div class="card-header">
                    <h5>About the Author</h5>
                </div>
                <div class="card-body text-center">
                    <#if message.author.avatarPath??>
                        <img src="${message.author.avatarPath}" alt="Avatar" class="avatar-lg rounded-circle mb-3">
                    <#else>
                        <div class="avatar-lg rounded-circle bg-secondary text-white d-flex align-items-center justify-content-center mx-auto mb-3">
                            ${message.author.username?substring(0,1)?upper_case}
                        </div>
                    </#if>
                    <h5>${message.author.username}</h5>
                    <#if message.author.bio?? && message.author.bio?has_content>
                        <p>${message.author.bio}</p>
                    <#else>
                        <p><em>No bio provided</em></p>
                    </#if>
                    <a href="/users/${message.author.id}" class="btn btn-outline-primary btn-sm">View Profile</a>
                </div>
            </div>
        </div>
    </div>
</@layout.base>
