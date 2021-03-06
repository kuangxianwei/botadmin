<div class="layui-card">
    <div class="layui-card-header layuiadmin-card-header-auto">
        <!--
        <div class="file_path_views">
            <div class="file_path_upper" title="上一层">
                <span class="glyphicon glyphicon-arrow-left"></span>
            </div>
            <div class="file_path_input">
                <div class="file_path_shadow"></div>
                <div class="file_dir_view" data-width="121">
                    <div class="file_dir_omit hide" title="展开已隐藏的目录">
                        <span></span><i class="iconfont icon-zhixiang-zuo"></i>
                        <div class="nav_down_list"></div>
                    </div>
                    <div class="file_dir_item" data-width="63"><span class="file_dir" title="/">根目录</span>
                        <i class="iconfont icon-arrow-right"></i>
                        <ul class="nav_down_list">
                            <li data-path="*"><span>加载中</span></li>
                        </ul>
                    </div>
                    <div class="file_dir_item" data-width="58"><span class="file_dir" title="/home">home</span>
                        <i class="iconfont icon-arrow-right"></i>
                        <ul class="nav_down_list">
                            <li data-path="*"><span>加载中</span></li>
                        </ul>
                    </div>
                </div>
                <input type="text" data-path="/home" data-backspace="" class="path_input" id="fileInputPath">
            </div>
            <div class="file_path_refresh" title="刷新列表"><i class="icon-file icon-file-refresh"></i></div>
            <div class="search_path_views">
                <input type="text" placeholder="搜索文件/目录" class="file_search_input">
                <button type="submit" class="path_btn"><i class="iconfont icon-search"></i></button>
                <div class="file_search_config">
                    <div id="search_all" class="file_search_checked"></div>
                    <label for="search_all">包含子目录</label>
                </div>
            </div>
        </div>
        -->
    </div>
    <div class="layui-card-body">
        <div class="layui-form table-search" style="left: 400px">
            <button class="layui-hide" lay-submit lay-filter="search">
                <i class="layui-icon layui-icon-search"></i>
            </button>
            <div class="layui-inline">
                <div class="layui-input-inline">
                    <input type="text" name="search_name" placeholder="完整或部分文件名称"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <div class="layui-input-inline">
                    <select name="search_type" lay-filter="search-select">
                        <option value="" selected>全部类型</option>
                        <option value="file">文件</option>
                        <option value="folder">目录</option>
                        <option value="compress">压缩文件</option>
                    </select>
                </div>
            </div>
        </div>
        <table class="layui-font" id="table-list" lay-filter="table-list"></table>
    </div>
</div>
<div class="layui-card">
    <div class="layui-card-body layui-form">
        <div class="layui-inline">
            <label class="layui-form-label">操作:</label>
            <div class="layui-input-block">
                <select name="act" lay-verify="" lay-search>
                    <option value="compress" selected>打包</option>
                    <option value="del">删除</option>
                    <option value="move">移动/重命名</option>
                    <option value="copy">复制</option>
                    <option value="chmod">修改权限</option>
                    <option value="user">所有者</option>
                    <option value="group">所有组</option>
                </select>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label" lay-tips="打包名/权限值/用户名/组名/目标文件或目录名">值:</label>
            <div class="layui-input-block">
                <input name="actname" type="text" class="layui-input layui-input-small"/>
            </div>
        </div>
        <div class="layui-inline">
            <div class="layui-input-inline">
                <input name="inherit" type="checkbox" title="继承" lay-skin="primary" checked/>
                <button class="layui-btn" lay-submit lay-filter="submit-acts">确定</button>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="toolbar">
    <div class="layui-btn-group">
        <button class="layui-btn layui-btn-sm" lay-event="rollback" lay-tips="上一层目录">
            <i class="layui-icon layui-icon-up"></i>
        </button>
        <button class="layui-btn layui-btn-sm" lay-event="back_root" lay-tips="用户目录">
            <i class="layui-icon layui-icon-home"></i>
        </button>
        <button class="layui-btn layui-btn-sm" lay-event="back_www" lay-tips="所有网站目录">
            <i class="layui-icon layui-icon-app"></i>
        </button>
        <button class="layui-btn layui-btn-sm" lay-event="new_folder" lay-tips="在当前目录新建文件夹">
            <i class="layui-icon layui-icon-add-1"></i><i class="layui-icon layui-icon-template"></i>
        </button>
        <button class="layui-btn layui-btn-sm" lay-event="new_file" lay-tips="在当前目录新建文件">
            <i class="layui-icon layui-icon-add-1"></i><i class="layui-icon layui-icon-file"></i>
        </button>
        <button class="layui-btn layui-btn-sm" lay-event="upload" id="upload" lay-tips="上传文件">
            <i class="layui-icon layui-icon-upload"></i>
        </button>
        <button class="layui-btn layui-btn-sm" lay-event="refresh" lay-tips="刷新当前路径">
            <i class="layui-icon layui-icon-refresh-3"></i>
        </button>
    </div>
    <div class="layui-form">
        <label>当前路径: <strong id="currentpath"></strong>&nbsp;&nbsp;&nbsp;</label>
        <i class="layui-icon layui-icon-right"></i>
        <div class="layui-input-inline">
            <input type="text" name="goto" placeholder="/root"
                   class="layui-input" style="height: 30px" required lay-verify="required">
        </div>
        <button class="layui-btn layui-btn-sm" lay-submit lay-filter="submit-goto" lay-tips="跳转到指定目录">
            <i class="layui-icon layui-icon-triangle-r"></i>
        </button>
    </div>
</script>
<script type="text/html" id="table-toolbar">
    {{html .operation}}
</script>
<script type="text/html" id="table-content-name">
    {{html .file_name}}
</script>
<script src="/static/layui/layui.js"></script>
<script>
    layui.use(['index', 'main'], function () {
        let form = layui.form,
            table = layui.table,
            main = layui.main,
            upload = layui.upload,
            url = {{.current_uri}},
            current_path = main.getParam('path') || "/home/wwwroot";
        $('#currentpath').text(current_path);
        // 列表管理
        table.render({
            headers: {'X-CSRF-Token':{{.csrf_token}}},
            method: 'post',
            elem: '#table-list',
            url: {{.current_uri}},
            toolbar: '#toolbar',
            where: {'path': current_path},
            cols: [[
                {type: 'checkbox', fixed: 'left'},
                {
                    field: 'name', minWidth: 100, title: '名称', sort: true,
                    templet: '#table-content-name'
                },
                {field: 'type', title: '类型', width: 100, sort: true},
                {field: 'uname', title: '所有者', width: 80},
                {field: 'gname', title: '所有组', width: 80},
                {field: 'uid', title: '用户ID', hide: true},
                {field: 'gid', title: '组ID', hide: true},
                {field: 'size', title: '文件大小', width: 100, sort: true},
                {field: 'mode', title: '权限', width: 100},
                {field: 'mtime', title: '最后修改', minWidth: 100, sort: true},
                {title: '操作', minWidth: 180, align: 'center', fixed: 'right', toolbar: '#table-toolbar'}
            ]],
            page: true,
            limit: 10,
            limits: [100, 200, 500, 1000],
            text: '对不起，加载出现异常！',
            done: function (res) {
                window.scrollTo(0, 0);
                if (res.path) {
                    current_path = res.path;
                    $('input[name="goto"]').keydown(function (event) {
                        if (event.keyCode === 13 && this.value) {
                            $('[lay-filter="submit-goto"]').click();
                        }
                    });
                }
                $('#currentpath').text(current_path);
                if (this.where) {
                    delete this.where.search_name;
                    delete this.where.search_type;
                    delete this.where.goto;
                }
                upload.render({
                    headers: {'X-CSRF-Token':{{.csrf_token}}},
                    elem: '#upload',
                    url: url + '/upload',
                    data: {'path': current_path},
                    accept: 'file',
                    done: function (res) {
                        table.reload('table-list', {
                            url: url,
                            where: {'path': current_path}
                        });
                        layer.msg(res.msg);
                    },
                });
            }
        });

        // 监听工具条
        table.on('tool(table-list)', function (obj) {
            let d = obj.data;
            switch (obj.event) {
                case 'del':
                    layer.confirm('删除后不可恢复！确定删除 ' + d.path + ' ?', function (index) {
                        main.req({
                            url: url + '/del',
                            data: {'name': d.path},
                            index: index,
                            ending: obj.del,
                        });
                    });
                    break;
                case 'filename':
                    if (d.type === 'folder') {
                        table.reload('table-list', {
                            url: url,
                            where: {'path': d.path}
                        });
                    } else {
                        let loadIndex = layer.load(1, {shade: [0.6, '#000', true]});
                        $.get(url + '/editor', {path: d.path, hide: true}, function (html) {
                            layui.layer.close(loadIndex);
                            main.popup({
                                title: '编辑文件',
                                content: html,
                            });
                            table.render();
                        });
                    }
                    break;
                case 'compress':
                    main.req({
                        url: url + '/compress',
                        data: {'name': d.path},
                        ending: function () {
                            table.reload('table-list', {
                                url: url,
                                where: {'path': current_path}
                            });
                        }
                    });
                    break;
                case 'decompress':
                    main.req({
                        url: url + '/decompress',
                        data: {'name': d.path},
                        ending: function () {
                            table.reload('table-list', {
                                url: url,
                                where: {'path': current_path}
                            });
                        }
                    });
                    break;
                case 'download':
                    window.open(encodeURI(url + '/download?file=' + d.path));
                    break;
            }
        });

        //监听工具栏
        table.on('toolbar(table-list)', function (obj) {
            switch (obj.event) {
                case 'rollback':
                    table.reload('table-list', {
                        url: url + '/rollback',
                        where: {'path': current_path}
                    });
                    break;
                case 'back_www':
                    table.reload('table-list', {
                        url: url,
                        where: {
                            path: '/home/wwwroot'
                        }
                    });
                    break;
                case 'back_root':
                    table.reload('table-list', {
                        url: url,
                        where: {
                            path: '/root'
                        }
                    });
                    break;
                case 'new_folder':
                    layer.prompt(
                        {
                            formType: 0,
                            value: 'webrobot.cn',
                            title: '请输入文件夹名不要有空格!'
                        },
                        function (value, index) {
                            main.req({
                                url: url + '/newfolder',
                                data: {
                                    name: value,
                                    path: current_path
                                },
                                index: index,
                                ending: function () {
                                    table.reload('table-list', {
                                        url: url,
                                        where: {
                                            path: current_path
                                        }
                                    });
                                }
                            });
                        });
                    break;
                case 'new_file':
                    layer.prompt(
                        {
                            formType: 0,
                            value: 'webrobot.cn',
                            title: '请输入文件名不要有空格!'
                        },
                        function (value, index) {
                            main.req({
                                url: url + '/newfile',
                                data: {
                                    name: value,
                                    path: current_path
                                },
                                index: index,
                                ending: function () {
                                    table.reload('table-list', {
                                        url: url,
                                        where: {
                                            path: current_path
                                        }
                                    });
                                }
                            });
                        }
                    );
                    break;
                case "refresh":
                    table.reload('table-list', {
                        url: url,
                        where: {
                            path: current_path
                        }
                    });
            }
        });

        //转到
        form.on('submit(submit-goto)', function (obj) {
            let field = obj.field, cols = [];
            $.each(field, function (k, v) {
                if (v) {
                    cols.push(k);
                } else {
                    delete field[k];
                }
            });
            field.cols = cols.join();
            if (!field.cols) {
                return location.reload();
            }
            field.path = current_path;
            table.reload('table-list', {
                url: url,
                where: field,
            });
            return false;
        });
        // 监听搜索
        main.onSearch({path: current_path});
        // 监听操作
        form.on('submit(submit-acts)', function (obj) {
            let checkData = table.checkStatus('table-list').data, // 得到选中的数据
                names = [];
            if (checkData.length === 0) {
                return layer.msg('请选择数据');
            }
            layui.each(checkData, function (k, v) {
                if (v.path !== undefined) {
                    names[k] = v.path;
                }
            });
            let field = obj.field;
            field.name = names.join();
            field.path = current_path;
            if (field.act === 'del') {
                layer.confirm('删除后不可恢复，确定批量删除吗？', function (index) {
                    main.req({
                        url: url + '/del',
                        data: field,
                        index: index,
                        ending: function () {
                            table.reload('table-list', {
                                url: url,
                                where: {path: current_path}
                            });
                        }
                    });
                });
            } else {
                main.req({
                    url: url + '/' + field.act,
                    data: field,
                    ending: function () {
                        table.reload('table-list', {
                            url: url,
                            where: {path: current_path}
                        });
                    }
                });
            }
            return false;
        });
        $('input[name="goto"]').keydown(function (event) {
            if (event.keyCode === 13 && this.value) {
                $('[lay-filter="submit-goto"]').click();
            }
        });
    });
</script>
