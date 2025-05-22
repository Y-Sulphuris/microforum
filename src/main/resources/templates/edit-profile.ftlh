<#import "layout/base.ftlh" as layout>

<@layout.base title="Edit Profile - MicroForum">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h4>Edit Profile</h4>
                </div>
                <div class="card-body">
                    <form action="/users/edit" method="post" enctype="multipart/form-data">
                        <div class="row mb-3">
                            <div class="col-md-4 text-center">
                                <#if user.avatarPath??>
                                    <img src="${user.avatarPath}" alt="Current Avatar" class="avatar-xl rounded-circle mb-3">
                                <#else>
                                    <div class="avatar-xl rounded-circle bg-secondary text-white d-flex align-items-center justify-content-center mx-auto mb-3">
                                        ${user.username?substring(0,1)?upper_case}
                                    </div>
                                </#if>
                                <div class="mb-3">
                                    <label for="avatar" class="form-label">Change Avatar</label>
                                    <input type="file" class="form-control" id="avatar" name="avatar" accept="image/*">
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="mb-3">
                                    <label for="username" class="form-label">Username</label>
                                    <input type="text" class="form-control" id="username" name="username" value="${user.username}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="bio" class="form-label">Bio</label>
                                    <textarea class="form-control" id="bio" name="bio" rows="3">${user.bio!""}</textarea>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="password" class="form-label">New Password (leave blank to keep current)</label>
                            <input type="password" class="form-control" id="password" name="password">
                        </div>
                        
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                            <a href="/users/profile" class="btn btn-outline-secondary">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</@layout.base>
