<div class="layui-card">
    <div class="layui-card-body layui-form">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">网站ID:</label>
                <div class="layui-input-inline">
                    <select name="site_id" lay-search lay-filter="site_id">
                        <option value="">搜索...</option>
                        {{range .sites -}}
                            <option value="{{.Id}}">{{.Vhost}}</option>
                        {{end -}}
                    </select>
                </div>
            </div>
            <div class="layui-inline" lay-tips="选择栏目ID">
                <label class="layui-form-label">栏目ID:</label>
                <div class="layui-input-block" lay-filter="class_id">
                    <select name="class_id">
                        <option value="">无...</option>
                    </select>
                </div>
            </div>
            <i class="layui-icon layui-icon-delete" lay-event="del"></i>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">已使用:</label>
            <div class="layui-input-inline">
                <input type="checkbox" name="used" lay-skin="switch" lay-text="是|否">
            </div>
            <i class="layui-icon layui-icon-delete" lay-event="del"></i>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" lay-tips="切换翻译错误">译错:</label>
            <div class="layui-input-inline">
                <input type="checkbox" name="trans_failed" lay-skin="switch" lay-text="是|否">
            </div>
            <i class="layui-icon layui-icon-delete" lay-event="del"></i>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">原创率:</label>
                <div class="layui-input-block">
                    <input type="radio" name="originality" value="0" title="不检验" checked>
                    <input type="radio" name="originality" value="1" title="未检验">
                    <input type="radio" name="originality" value="2" title="已检验">
                </div>
            </div>
            <i class="layui-icon layui-icon-delete" lay-event="del"></i>
        </div>
        <div class="layui-hide">
            <input type="hidden" name="ids" value="{{.ids}}">
            <button class="layui-btn" lay-submit lay-filter="submit">提交</button>
        </div>
    </div>
</div>
<script>
    layui.use(['index', 'main'], function () {
        let main = layui.main,
            form = layui.form,
            class_id = $('select[name=class_id]').val();
        main.on.del();
        form.on('select(site_id)', function (obj) {
            if (obj.value === 0 || obj.value === "") {
                $('div[lay-filter=class_id]').html('<select name="class_id"><option value="">无...</option></select>');
                form.render();
                return false;
            }
            $.get('/site/class', {id: obj.value, class_id: class_id}, function (res) {
                switch (res.code) {
                    case -1:
                        layer.alert(res.msg, {icon: 2});
                        break;
                    case 0:
                        $('div[lay-filter=class_id]').html(res.data);
                        form.render();
                        break;
                }
            });
        });
    });
</script>