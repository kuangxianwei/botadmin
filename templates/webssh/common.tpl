<div class="layui-card">
    <div class="layui-card-body layui-form" id="form">
        <div class="layui-form-item">
            <label for="alias" class="layui-form-label">别名:</label>
            <div class="layui-input-block">
                <input type="text" name="alias" id="alias" placeholder="本机" value="{{.obj.Alias}}" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item layui-row">
            <div class="layui-col-md6">
                <label for="host" class="layui-form-label">Host:</label>
                <div class="layui-input-inline">
                    <input type="text" name="host" id="host" placeholder="host" value="{{.obj.Host}}" class="layui-input" lay-verify="required">
                </div>
            </div>
            <div class="layui-col-md6">
                <label for="port" class="layui-form-label">Port:</label>
                <div class="layui-input-inline">
                    <input type="number" name="port" id="port" placeholder="port" value="{{.obj.Port}}" class="layui-input" lay-verify="required">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">认证类型:</label>
            <div class="layui-input-block">
                <input type="radio" name="auth" value="pwd" title="密码认证" lay-filter="auth"{{if eq .obj.Auth "pwd"}} checked{{end}}>
                <input type="radio" name="auth" value="key" title="秘钥认证" lay-filter="auth"{{if eq .obj.Auth "key"}} checked{{end}}>
            </div>
        </div>
        <div class="layui-form-item layui-row">
            <div class="layui-col-md6">
                <label for="user" class="layui-form-label">User:</label>
                <div class="layui-input-inline">
                    <input type="text" name="user" id="user" placeholder="user" value="{{.obj.User}}" class="layui-input" lay-verify="required">
                </div>
            </div>
            <div class="layui-col-md6" id="auth">
                {{if eq .obj.Auth "pwd" -}}
                    <label for="passwd" class="layui-form-label">Passwd:</label>
                    <div class="layui-input-inline">
                        <input type="password" name="passwd" id="passwd" placeholder="{{if eq .obj.Id 0 -}}SSH密码{{else}}留空为不修改密码{{end}}" value="" class="layui-input">
                    </div>
                {{else -}}
                    <label for="control_host" class="layui-form-label">SSH-KEY:</label>
                    <div class="layui-input-block">
                        <textarea name="ssh_key" class="layui-textarea" lay-verify="required">{{.obj.SshKey}}</textarea>
                    </div>
                {{end -}}
            </div>
        </div>
        <div class="layui-form-item layui-row">
            <div class="layui-col-md6">
                <label for="control_host" class="layui-form-label">控制台地址:</label>
                <div class="layui-input-inline">
                    <input type="text" name="control_host" id="control_host" placeholder="默认填充为Host地址" value="{{.obj.ControlHost}}" class="layui-input">
                </div>
            </div>
            <div class="layui-col-md6">
                <label for="control_port" class="layui-form-label">控制台端口:</label>
                <div class="layui-input-inline">
                    <input type="number" name="control_port" id="control_port" value="{{.obj.ControlPort}}" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item layui-row">
            <div class="layui-col-md6">
                <label for="control_username" class="layui-form-label">控制台用户:</label>
                <div class="layui-input-inline">
                    <input type="text" name="control_username" id="control_username" placeholder="用户名称" value="{{.obj.ControlUsername}}" class="layui-input">
                </div>
            </div>
            <div class="layui-col-md6">
                <label for="control_password" class="layui-form-label">控制台密码:</label>
                <div class="layui-input-inline">
                    <input type="text" name="control_password" id="control_password" value="{{.obj.ControlPassword}}" class="layui-input">
                </div>
            </div>
        </div>
        <input type="hidden" name="id" value="{{.obj.Id}}">
        <button class="layui-hide" lay-submit></button>
    </div>
</div>
<script>
    layui.use(['index', 'main'], function () {
        let form = layui.form,
            defaultData ={{.obj}};
        form.on('radio(auth)', (obj) => {
            let authElem = $('#auth');
            authElem.empty();
            if (obj.value === "pwd") {
                authElem.html(`<label class="layui-form-label">Passwd:</label>
                    <div class="layui-input-inline">
                        <input type="password" name="passwd" id="passwd" placeholder="` + (defaultData.id === 0 ? "SSH密码" : "留空为不修改密码") + `" value="" class="layui-input">
                    </div>`);
            } else {
                authElem.html(`<label class="layui-form-label">SSH-KEY:</label>
                    <div class="layui-input-block">
                        <textarea name="ssh_key" class="layui-textarea" lay-verify="required">` + defaultData.ssh_key + `</textarea>
                    </div>`);
            }
            form.render();
        });
    });
</script>