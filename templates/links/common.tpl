<div class="layui-card">
    <div class="layui-card-body layui-form">
        <div class="layui-form-item layui-row">
            <div class="layui-col-md4">
                <label for="name" class="layui-form-label">名称:</label>
                <div class="layui-input-block">
                    <input type="text" name="name" id="name" value="{{.obj.Name}}" placeholder="默认名称" class="layui-input" lay-verify="required">
                </div>
            </div>
            <div class="layui-col-md4" style="text-align:center">
                <input name="global" type="checkbox" lay-tips="默认不选，只在主页和栏目也添加链接" title="全局" {{if .obj.Global}} checked{{end}}/>
                <input name="enabled" type="checkbox" title="定时" {{if .obj.Enabled}} checked{{end}}/>
                <input name="anchored" type="checkbox" title="锚链" {{if .obj.Anchored}} checked{{end}}/>
            </div>
            <div class="layui-col-md4">
                <label for="spec" class="layui-form-label">定时规则:</label>
                <div class="layui-input-block">
                    <input class="layui-input" type="text" name="spec" id="spec" value="{{.obj.Spec}}">
                </div>
            </div>
        </div>
        <div class="layui-form-item layui-row">
            <div class="layui-col-md9">
                <label class="layui-form-label" lay-tips="随机插入链接数量范围">链接范围:</label>
                <div class="layui-input-block">
                    <div id="range" class="slider-block"></div>
                    <input type="hidden" name="range" value="{{print .obj.Range}}"/>
                </div>
            </div>
            <div class="layui-col-md3" lay-tips="不选择则会在留痕结果中抽取,默认不选择" style="padding-left:10px;">
                <div class="layui-input-inline">
                    <input name="customize" type="checkbox" lay-filter="customize" title="定制链接" {{if .obj.Customize}} checked{{end}}/>
                    <div class="layui-form-mid" style="float:right;">
                        <a lay-href="/file?path=data/ad/links" class="layui-inline" lay-text="外链库" style="color:#0a93bf">定制外链库</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <input type="hidden" name="site_ids" value="{{join .obj.SiteIds ","}}" lay-verify="siteIds">
            <div id="site_ids" style="text-align:center"></div>
        </div>
        <div class="layui-form-item">
            <label for="css" class="layui-form-label">CSS:</label>
            <div class="layui-input-block">
                <textarea class="layui-textarea" name="css" id="css" placeholder=".links{width:100%;margin:0 auto;}&#10;.links>li{list-style:none;float:left;margin:6px;}&#10;.links>li>a{text-decoration:none;}">{{.obj.Css}}</textarea>
            </div>
        </div>
        <div class="layui-hide">
            <input type="hidden" name="id" value="{{.obj.Id}}">
            <button lay-submit>提交</button>
        </div>
    </div>
</div>
<script>
    layui.main.slider({elem: '#range', range: true, min: 1, max: 50});
    layui.main.cron('[name=spec]');
    //显示
    layui.transfer.render({
        id: 'siteIdsData',
        elem: '#site_ids',
        title: ['全部用户', '已选用户'],
        data: {{.siteData}},
        value: {{.siteValue}},
        showSearch: true,
        onchange: function () {
            let data = layui.transfer.getData('siteIdsData');
            let ids = [];
            for (let i = 0; i < data.length; i++) {
                ids.push(data[i].value)
            }
            $('input[name=site_ids]').val(ids.join(','))
        }
    });
    layui.form.verify({
        siteIds: function (value) {
            if (!value) {
                return '最少要选择一个用户列表到右边';
            }
        }
    });
</script>