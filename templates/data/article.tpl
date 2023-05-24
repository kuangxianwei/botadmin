<div class="layui-card">
    <div class="layui-form layui-card-header layuiadmin-card-header-auto" lay-event="search">
        <div class="layui-inline">
            <input type="text" autocomplete="off" name="ids" placeholder="搜索ID:1,2,3" class="layui-input">
        </div>
        <div class="layui-inline">
            <input class="layui-input" type="text" autocomplete="off" name="title" placeholder="请输入标题部分或全部">
        </div>
        <div class="layui-inline" style="width: 80px" lay-tips="原创度 例如:70.00">
            <input type="number" autocomplete="off" name="originality_rate" placeholder="70.00" class="layui-input">
        </div>
        <div class="layui-inline">
            <select name="site_id" lay-filter="search-select" lay-search>
                <option value="">隶属网站</option>
                {{range .sites -}}
                    <option value="{{.Id}}">{{.Vhost}}</option>
                {{end -}}
            </select>
        </div>
        <div class="layui-inline" style="width: 100px">
            <select name="used" lay-filter="search-select" lay-search>
                <option value="">使用状态</option>
                <option value="true">已使用</option>
                <option value="false">未使用</option>
            </select>
        </div>
        <div class="layui-inline" style="width: 100px">
            <select name="trans_failed" lay-filter="search-select" lay-search>
                <option value="">翻译状态</option>
                <option value="true">已出错</option>
                <option value="false">未出错</option>
            </select>
        </div>
        <div class="layui-inline" style="width: 100px">
            <select name="originality" lay-filter="search-select">
                <option value="">原创状态</option>
                <option value="0">不检验</option>
                <option value="1">未检验</option>
                <option value="2">已检验</option>
            </select>
        </div>
        <button class="layui-btn" data-type="reload" lay-submit lay-filter="search">
            <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
        </button>
    </div>
    <div class="layui-card-body">
        <table id="table-list" lay-filter="table-list"></table>
    </div>
</div>
<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <div class="layui-btn-group">
            <button class="layui-btn layui-btn-sm" lay-event="import" lay-tips="导入 tag.gz|.zip 格式的压缩文件">
                <i class="layui-icon iconfont icon-import"></i>
            </button>
            <button class="layui-btn layui-btn-sm" lay-event="export" lay-tips="导出文章">
                <i class="layui-icon iconfont icon-export"></i>
            </button>
            <button class="layui-btn layui-btn-sm" lay-event="configure" lay-tips="批量修改配置">
                <i class="layui-icon layui-icon-set"></i>
            </button>
        </div>
        <div class="layui-btn-group">
            <button class="layui-btn layui-btn-sm" lay-event="ban" id="LAY_layer_iframe_ban"
                    lay-tips="过滤违禁词">
                <i class="layui-icon layui-icon-find-fill"></i>检违禁
            </button>
            <button class="layui-btn layui-btn-sm" lay-event="originalityExec">
                <i class="layui-icon layui-icon-vercode"></i>检原创
            </button>
            <button class="layui-btn layui-btn-sm" lay-event="conversionExec">
                转换简繁体
            </button>
        </div>
        <div class="layui-btn-group">
            <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del" id="LAY_layer_iframe_del"
                    lay-tips="删除选中的文章列表">
                <i class="layui-icon layui-icon-delete"></i>
            </button>
            <button class="layui-btn layui-btn-sm  layui-btn-danger" lay-event="delUsed"
                    id="LAY_layer_iframe_delUsed" lay-tips="删除所有已经发布过的文章">
                <i class="layui-icon layui-icon-delete"></i>已发布
            </button>
            <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="truncate"
                    id="LAY_layer_iframe_truncate" lay-tips="清空所有的文章数据，不可恢复！">
                <i class="layui-icon layui-icon-delete"></i>清空
            </button>
        </div>
        <div class="layui-btn-group">
            <button class="layui-btn layui-btn-sm" lay-event="case" id="LAY_layer_iframe_case"
                    lay-tips="查看采集文章范本">范
            </button>
            <button class="layui-btn layui-btn-sm" lay-event="translate" id="LAY_layer_iframe_translate"
                    lay-tips="翻译成指定的语言">译
            </button>
        </div>
        <div class="layui-btn-group">
            <button class="layui-btn layui-btn-sm" lay-event="log" lay-tips="查看日志">
                <i class="layui-icon layui-icon-log"></i>
            </button>
            <button class="layui-btn layui-btn-sm layui-bg-red" lay-event="resetLog" lay-tips="重置日志">
                <i class="layui-icon iconfont icon-reset"></i>Log
            </button>
        </div>
    </div>
</script>
<script type="text/html" id="table-toolbar">
    <div class="layui-btn-group">
        <button class="layui-btn layui-btn-xs" lay-event="modify">
            <i class="layui-icon layui-icon-edit"></i>
        </button>
        <button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">
            <i class="layui-icon layui-icon-delete"></i>
        </button>
        <button class="layui-btn layui-btn-xs" lay-event="log" lay-tips="查看日志">
            <i class="layui-icon layui-icon-log"></i>
        </button>
    </div>
</script>
<script src="/static/layui/layui.js"></script>
<script>
    layui.use(['index', 'main'], function () {
        let main = layui.main,
            form = layui.form;
        main.upload();
        main.table([[
            {type: 'checkbox', fixed: 'left'},
            {field: 'id', title: 'ID', hide: true},
            {
                field: 'title',
                title: '标题',
                event: 'modify',
                style: 'cursor:pointer;color:#01aaed;font-weight:bold'
            },
            {
                field: 'originality_rate',
                title: '原创率',
                align: 'center',
                sort: true,
                width: 120,
                templet: function (d) {
                    let val = (d['originality_rate'] * 100).toFixed(2) + '%';
                    if (d['originality_rate'] < 0.35) {
                        return '<b style="color: red">' + val + '</b>';
                    }
                    if (d['originality_rate'] > 0.69) {
                        return '<b style="color:#01aaed;">' + val + '</b>';
                    }
                    return val;
                },
            },
            {field: 'description', title: '描述', hide: true},
            {field: 'tags', title: 'Tags', hide: true},
            {field: 'site_id', title: '绑定网站ID', hide: true},
            {field: 'class_id', title: '文章ID', hide: true},
            {
                field: 'used', title: '已使用', align: 'center', width: 92, unresize: true, event: 'used',
                templet: function (d) {
                    let msg = '<input data-id="' + d.id + '" type="checkbox" name="used" lay-skin="switch" lay-text="是|否" lay-filter="used"';
                    if (d.used) {
                        msg += ' checked>';
                    } else {
                        msg += '>';
                    }
                    return msg;
                },
                sort: true
            },
            {
                field: 'ban_vetted',
                title: '过滤违禁',
                align: 'center',
                width: 92,
                unresize: true,
                event: 'ban_vetted',
                templet: function (d) {
                    let msg = '<input data-id="' + d.id + '" type="checkbox" name="ban_vetted" lay-skin="switch" lay-text="是|否" lay-filter="banVetted"';
                    if (d.ban_vetted) {
                        msg += ' checked>';
                    } else {
                        msg += '>';
                    }
                    return msg;
                },
                sort: true,
                hide: true
            },
            {
                field: 'trans_failed',
                title: '译错',
                align: 'center',
                width: 92,
                unresize: true,
                event: 'trans_failed',
                templet: function (d) {
                    let msg = '<input data-id="' + d.id + '" type="checkbox" name="trans_failed" lay-skin="switch" lay-text="是|否" lay-filter="transFailed"';
                    if (d.trans_failed) {
                        msg += ' checked>';
                    } else {
                        msg += '>';
                    }
                    return msg;
                },
                sort: true
            },
            {
                field: 'updated', title: '时间', align: 'center', width: 180, sort: true, templet: function (d) {
                    return main.timestampFormat(d['updated']);
                }
            },
            {title: '操作', width: 120, align: 'center', fixed: 'right', toolbar: '#table-toolbar'}]], {
            modify: function (obj) {
                main.get(url + '/modify', {id: obj.data.id}, function (html) {
                    main.popup({
                        title: '修改文章',
                        url: url + '/modify',
                        content: html,
                        done: 'table-list',
                    });
                });
            },
            configure: function (obj, ids) {
                if (obj.data.length === 0) {
                    layer.msg('请勾选数据', {icon: 2});
                    return false;
                }
                main.get(url + '/configure', {ids: ids.join()}, function (html) {
                    main.popup({
                        title: "批量修改配置",
                        content: html,
                        url: url + '/configure',
                        done: 'table-list',
                    });
                });
            },
            originalityExec: function (obj, ids) {
                if (obj.data.length === 0) {
                    layer.msg('请勾选数据', {icon: 2});
                    return false;
                }
                main.request({
                    url: url + '/original',
                    data: {ids: ids.join()},
                    done: function () {
                        main.ws.log('article.0');
                        return false;
                    },
                });
            },
            conversionExec: function (obj, ids) {
                if (obj.data.length === 0) {
                    layer.msg('请勾选数据', {icon: 2});
                    return false;
                }
                main.get(url + '/convert', {ids: ids.join()}, function (html) {
                    main.popup({
                        title: '简繁体转换',
                        content: html,
                        url: url + '/convert',
                        area: ['280px', '300px'],
                        done: 'table-list'
                    });
                });
            },
            originality: function (obj, ids) {
                if (obj.data.length === 0) {
                    layer.msg('请勾选数据', {icon: 2});
                    return false;
                }
                let val = this.value;
                main.request({
                    url: url + '/original',
                    data: {ids: ids.join(), originality: val},
                    done: "table-list"
                });
            },
            ban: function (obj, ids) {
                if (obj.data.length === 0) {
                    layer.msg('请勾选数据', {icon: 2});
                    return false;
                }
                main.request({
                    url: url + '/ban',
                    data: {thread: obj.data.length, ids: ids.join()},
                    done: function () {
                        main.ws.log('article.0');
                        return false;
                    }
                });
            },
            case: function () {
                main.get(url + '/case', function (html) {
                    main.popup({
                        title: '采集范本',
                        content: html,
                        btn: ['关闭'],
                        yes: function (index) {
                            layer.close(index);
                            return false;
                        },
                    });
                });
            },
            translate: function (obj, ids) {
                if (obj.data.length === 0) {
                    layer.msg('请勾选数据', {icon: 2});
                    return false;
                }
                main.get(url + '/translate', {ids: ids.join()}, function (html) {
                    main.popup({
                        title: '翻译',
                        content: html,
                        url: url + '/translate',
                        area: ['750px', '300px'],
                        done: function () {
                            main.ws.log('article.0');
                            return false;
                        },
                    });
                    form.render();
                });
            },
            delUsed: function () {
                layer.confirm('删除所有已经发布是文章列表？', function (index) {
                    main.request({
                        url: url + '/del/used',
                        index: index,
                        done: 'table-list'
                    });
                });
            },
        });
        // 切换是否已经使用
        form.on('switch(used)', function (obj) {
            let id = $(this).attr('data-id'),
                checked = this.checked;
            if (!id) {
                layer.tips('ID为空，无法操作！', obj.othis);
                return false;
            }
            main.request({
                url: url + '/configure',
                data: {id: id, used: checked, cols: 'used'},
                done: 'table-list',
            });
        });
        // 切换翻译错误
        form.on('switch(transFailed)', function (obj) {
            let id = $(this).attr('data-id'),
                checked = this.checked;
            if (!id) {
                layer.tips('ID为空，无法操作！', obj.othis);
                return false;
            }
            main.request({
                url: url + '/configure',
                data: {id: id, trans_failed: checked, cols: 'trans_failed'},
                done: 'table-list',
            });
            return false;
        });
        // 切换过滤
        form.on('switch(banVetted)', function (obj) {
            let id = $(this).attr('data-id'),
                checked = this.checked;
            if (!id) {
                layer.tips('ID为空，无法操作！', obj.othis);
                return false;
            }
            main.request({
                url: url + '/toggle',
                data: {'id': id, "ban_vetted": checked},
                done: 'table-list',
            });
            return false;
        });
    });
</script>