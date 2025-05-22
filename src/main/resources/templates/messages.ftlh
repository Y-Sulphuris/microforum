<#import "layout/base.ftlh" as layout>

<@layout.base title="Messages - MicroForum">
    <div class="row">
        <div class="col-md-8">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4>Messages</h4>
                    <#if currentUser??>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#newMessageModal">
                            <i class="bi bi-plus-circle"></i> New Message
                        </button>
                    </#if>
                </div>
                <div class="card-body">
                    <#if messages?? && messages?size gt 0>
                        <div class="list-group">
                            <#list messages as message>
                                <a href="/messages/${message.id}" class="list-group-item list-group-item-action">
                                    <div class="d-flex w-100 justify-content-between">
                                        <h5 class="mb-1">${message.title}</h5>
                                        <small>${message.createdAt.toString()}</small>
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
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card">
                <div class="card-header">
                    <h4>About Messages</h4>
                </div>
                <div class="card-body">
                    <p>This is the main message board where you can:</p>
                    <ul>
                        <li>Create new discussion topics</li>
                        <li>Reply to existing messages</li>
                        <li>Engage with other users</li>
                    </ul>
                    <#if !currentUser??>
                        <div class="alert alert-info">
                            <p>You need to <a href="/login">login</a> to post messages.</p>
                        </div>
                    </#if>
                </div>
            </div>
        </div>
    </div>

    <#if currentUser??>
        <div class="modal fade" id="newMessageModal" tabindex="-1" aria-labelledby="newMessageModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="/messages" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title" id="newMessageModalLabel">Create New Message</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="title" class="form-label">Title</label>
                                <input type="text" class="form-control" id="title" name="title" required>
                            </div>
                            <div class="mb-3">
                                <label for="content" class="form-label">Content</label>
                                <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Post Message</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </#if>
</@layout.base>
