<div class="layui-card">
    <div class="layui-card-body layui-form">
        <div class="layui-form-item">
            <label for="id" class="layui-form-label">选择推送:</label>
            <div class="layui-input-inline">
                <select name="id" id="id" lay-search>
                    <option value="0">不选择</option>
                    {{range .objs -}}
                        <option value="{{.Id}}"{{if eq $.obj.Id .Id}} selected{{end}}>{{.Username}}</option>
                    {{end -}}
                </select>
            </div>
        </div>
        <div class="layui-form-item layui-hide">
            <input type="hidden" name="site_id" value="{{.obj.SiteId}}">
            <input type="hidden" name="old_id" value="{{.obj.Id}}">
            <input type="hidden" name="act" value="relationship">
            <button lay-submit></button>
        </div>
    </div>
</div>