<div class="layui-row layui-col-space15">
    <div class="layui-card">
        <div class="layui-card-header">PING设置</div>
        <div class="layui-card-body layui-form">
            <div class="layui-form-item">
                <label class="layui-form-label">设置</label>
                <div class="layui-input-block">
                    <input type="checkbox" name="used_ping" lay-skin='switch' lay-text="开启|关闭"
                           lay-filter="used_ping"{{if .used_ping}} checked{{end}}>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="layui-row layui-col-space15">
    <blockquote class="layui-elem-quote">
        1 ping是一个可以检测网络连通性及机器存活状态的一个程序。但同时也是一个很多入侵和攻击的开始。所以，禁止ping在一定程序上，可以增加安全性。<br/>
        2 由于OepnVZ虚拟化限制，此功能在OpenVZ的VPS上无效。
    </blockquote>
</div>
<script src="/static/layui/layui.js"></script>
<script>
    layui.use(['index', 'main'], function () {
        let main = layui.main,
            form = layui.form,
            url = {{.current_uri}};

        form.render();
        //监听开关
        form.on('switch(used_ping)', function (obj) {
            main.req({
                url: url,
                data: {'used_ping': obj.elem.checked},
            });
            return false;
        });
    });
</script>
