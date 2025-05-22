<#import "layout/base.ftlh" as layout>

<@layout.base title="Edit Message - MicroForum">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h4>Edit Message</h4>
                </div>
                <div class="card-body">
                    <form action="/messages/${message.id}/edit" method="post">
                        <div class="mb-3">
                            <label for="title" class="form-label">Title</label>
                            <input type="text" class="form-control" id="title" name="title" value="${message.title}" required>
                        </div>
                        <div class="mb-3">
                            <label for="content" class="form-label">Content</label>
                            <textarea class="form-control" id="content" name="content" rows="5" required>${message.content}</textarea>
                        </div>
                        <div class="d-flex justify-content-between">
                            <a href="<#if message.parentMessage??>
                                      /messages/${message.parentMessage.id}
                                    <#else>
                                      /messages/${message.id}
                                    </#if>" class="btn btn-outline-secondary">Cancel</a>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</@layout.base>
