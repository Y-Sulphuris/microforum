<#import "layout/base.ftlh" as layout>

<@layout.base title="${profileUser.username}'s Profile - MicroForum">
    <div class="row">
        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-header">
                    <h4>Profile</h4>
                </div>
                <div class="card-body text-center">
                    <#if profileUser.avatarPath??>
                        <img src="${profileUser.avatarPath}" alt="Avatar" class="avatar-xl rounded-circle mb-3">
                    <#else>
                        <div class="avatar-xl rounded-circle bg-secondary text-white d-flex align-items-center justify-content-center mx-auto mb-3">
                            ${profileUser.username?substring(0,1)?upper_case}
                        </div>
                    </#if>
                    <h3>${profileUser.username}</h3>
                    <p class="text-muted">Member since: ${profileUser.createdAt.toString()}</p>
                    
                    <#if profileUser.bio?? && profileUser.bio?has_content>
                        <div class="mb-3">
                            <h5>Bio</h5>
                            <p>${profileUser.bio}</p>
                        </div>
                    </#if>
                    
                    <#if isOwner>
                        <a href="/users/edit" class="btn btn-primary">Edit Profile</a>
                    </#if>
                </div>
            </div>
            
            <div class="card mb-4">
                <div class="card-header">
                    <h4>Stats</h4>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            Messages
                            <span class="badge bg-primary rounded-pill">${messages?size}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            Posts
                            <span class="badge bg-primary rounded-pill">${posts?size}</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        
        <div class="col-md-8">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4>Posts</h4>
                    <#if isOwner>
                        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#newPostModal">
                            <i class="bi bi-plus-circle"></i> New Post
                        </button>
                    </#if>
                </div>
                <div class="card-body">
                    <#if posts?? && posts?size gt 0>
                        <div class="posts">
                            <#list posts as post>
                                <div class="post mb-4">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <div class="d-flex align-items-center">
                                            <#if profileUser.avatarPath??>
                                                <img src="${profileUser.avatarPath}" alt="Avatar" class="avatar-sm rounded-circle me-2">
                                            <#else>
                                                <div class="avatar-sm rounded-circle bg-secondary text-white d-flex align-items-center justify-content-center me-2">
                                                    ${profileUser.username?substring(0,1)?upper_case}
                                                </div>
                                            </#if>
                                            <span>${profileUser.username}</span>
                                        </div>
                                        <small>${post.createdAt.toString()}</small>
                                    </div>
                                    <p>${post.content}</p>
                                    
                                    <#if isOwner>
                                        <div class="btn-group">
                                            <a href="/posts/${post.id}/edit" class="btn btn-sm btn-outline-primary">Edit</a>
                                            <form action="/posts/${post.id}/delete" method="post" class="d-inline">
                                                <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure you want to delete this post?')">Delete</button>
                                            </form>
                                        </div>
                                    </#if>
                                </div>
                                <hr>
                            </#list>
                        </div>
                    <#else>
                        <p class="text-center">No posts yet.</p>
                    </#if>
                </div>
            </div>
            \
            <div class="card">
                <div class="card-header">
                    <h4>Recent Messages</h4>
                </div>
                <div class="card-body">
                    <#if messages?? && messages?size gt 0>
                        <div class="list-group">
                            <#list messages as message>
                                <#if message??>
									<a href="/messages/${message.id}" class="list-group-item list-group-item-action">
										<div class="d-flex w-100 justify-content-between">
											<h5 class="mb-1">${(message.title)!''}</h5>
											<small>${message.createdAt.toString()}</small>
										</div>
										<p class="mb-1">${message.content?truncate(100)}</p>
                                        <#if message.replies?? && message.replies?size gt 0>
											<small>${message.replies?size} replies</small>
                                        </#if>
									</a>
                                </#if>
                            </#list>
                        </div>
                    <#else>
                        <p class="text-center">No messages yet.</p>
                    </#if>
                </div>
            </div>
        </div>
    </div>
    
    <#if isOwner>\
        <div class="modal fade" id="newPostModal" tabindex="-1" aria-labelledby="newPostModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="/posts" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title" id="newPostModalLabel">Create New Post</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="content" class="form-label">Content</label>
                                <textarea class="form-control" id="content" name="content" rows="4" required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Post</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </#if>
</@layout.base>
