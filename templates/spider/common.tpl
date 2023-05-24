<div class="steps-content layui-form">
    <div>
        <fieldset class="layui-elem-field">
            <legend>基本配置</legend>
            <div class="layui-form-item">
                <label class="layui-form-label" lay-tips="任务名称必须由中文、数字、字母、下划线组成 唯一">任务名称:</label>
                <div class="layui-input-block">
                    <input type="hidden" name="id" value="{{.obj.Id}}" placeholder="本ID">
                    <input type="text" autocomplete="off" name="name" value="{{.obj.Name}}" class="layui-input" required lay-verify="name" placeholder="采集名称">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-row layui-col-space10">
                    <div class="layui-col-sm6">
                        <label for="seeds" class="layui-form-label">初始种子:</label>
                        <div class="layui-input-block">
                            <textarea name="seeds" id="seeds" class="layui-textarea" required lay-verify="seeds" placeholder="http://www.botadmin.cn&#13;http://www.nfivf.com">{{join .obj.Seeds "\n"}}</textarea>
                        </div>
                    </div>
                    <div class="layui-col-sm6">
                        <label for="note" class="layui-form-label">备注:</label>
                        <div class="layui-input-block">
                            <textarea name="note" id="note" class="layui-textarea" placeholder="这是一个seo网站">{{.obj.Note}}</textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-collapse" lay-accordion>
                    <div class="layui-colla-item">
                        <h2 class="layui-colla-title">翻译处理</h2>
                        <div class="layui-colla-content">
                            <div id="trans-items"></div>
                            <input type="hidden" name="trans">
                            <button class="layui-btn layui-btn-sm layui-btn-radius" lay-event="add-trans"
                                    style="margin: 10px 40px"
                                    lay-tips="新增一次翻译 则多翻译一次 例如：中文 -> 泰文 -> 英文 -> 中文 这样就翻译了3次">
                                <i class="layui-icon layui-icon-add-circle"></i>新增翻译引擎
                            </button>
                        </div>
                    </div>
                    <div class="layui-colla-item">
                        <h2 class="layui-colla-title">高级选项</h2>
                        <div class="layui-colla-content">
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label for="user_agent" class="layui-form-label" lay-tips="模拟访问 默认为百度蜘蛛">模拟访问:</label>
                                    <div class="layui-input-inline">
                                        <select name="user_agent" id="user_agent" class="layui-select" lay-search>
                                            {{range .userAgents -}}
                                                <option value="{{.Value}}"{{if eq $.obj.UserAgent .Value}} selected{{end}}>{{.Alias}}</option>
                                            {{end -}}
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">原创率:</label>
                                    <div class="layui-input-block">
                                        <input type="radio" name="originality" value="0"
                                               title="不检验"{{if eq .obj.Originality 0}} checked{{end}}>
                                        <input type="radio" name="originality" value="1"
                                               title="未检验"{{if eq .obj.Originality 1}} checked{{end}}>
                                        <input type="radio" name="originality" value="2"
                                               title="已检验"{{if eq .obj.Originality 2}} checked{{end}}>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label for="order" class="layui-form-label" lay-tips="采集入库顺序">入库:</label>
                                    <div class="layui-input-block">
                                        <select name="order" id="order" class="layui-select">
                                            <option value="0"{{if eq .obj.Order 0}} selected{{end}}>正序</option>
                                            <option value="1"{{if eq .obj.Order 1}} selected{{end}}>倒序</option>
                                            <option value="2"{{if eq .obj.Order 2}} selected{{end}}>URL升序</option>
                                            <option value="3"{{if eq .obj.Order 3}} selected{{end}}>URL降序</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label for="delay" class="layui-form-label"
                                           lay-tips="采集间隔 单位为秒 10-20 随机最少10秒最多20秒">Delay:</label>
                                    <div class="layui-input-block">
                                        <input type="text" autocomplete="off" name="delay" id="delay" class="layui-input" value="{{print .obj.Delay}}" placeholder="10-20">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label for="charset" class="layui-form-label" lay-tips="指定字符集">字符集:</label>
                                    <div class="layui-input-block">
                                        <select name="charset" id="charset" class="layui-select">
                                            <option value="">自动</option>
                                            <option value="utf-8"{{if eq .obj.Charset "utf-8"}} selected{{end}}>UTF-8
                                            </option>
                                            <option value="gbk"{{if eq .obj.Charset "gbk"}} selected{{end}}>GBK
                                            </option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label for="decode" class="layui-form-label" lay-tips="内容解码">解码:</label>
                                    <div class="layui-input-block">
                                        <select name="decode" id="decode" class="layui-select">
                                            <option>无</option>
                                            {{range .decodes -}}
                                                <option value="{{.}}"{{if eq $.obj.Decode . }} selected{{end}}>{{.}}</option>
                                            {{end -}}
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label for="conversion" class="layui-form-label" lay-tips="繁体中文和简体中文转换">繁简转换:</label>
                                    <div class="layui-input-block">
                                        <select name="conversion" id="conversion" class="layui-select">
                                            <option>无...</option>
                                            {{range .conversions -}}
                                                <option value="{{.Name}}"{{if eq $.obj.Conversion .Name }} selected{{end}}>{{.Alias}}</option>
                                            {{end -}}
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline" style="width: 48%">
                                    <label for="next_dom" class="layui-form-label">cookies:</label>
                                    <div class="layui-input-block">
                                        <textarea name="cookies" class="layui-textarea" placeholder="格式 key1=value1; key2=value2; 或者一行一条">{{.obj.Cookies}}</textarea>
                                    </div>
                                </div>
                                <div class="layui-inline" style="width: 48%">
                                    <label for="next_dom" class="layui-form-label">允许域名:</label>
                                    <div class="layui-input-block">
                                        <textarea name="allow_domains" class="layui-textarea" placeholder="*.nfivf.com&#13;*.botadmin.cn">{{.obj.AllowDomains}}</textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </fieldset>
    </div>
    <div>
        <fieldset class="layui-elem-field layui-field-title" style="margin-top:0;">
            <legend><i class="layui-icon layui-icon-add-circle" id="add-rule" data-event="addRule"></i>新增规则</legend>
        </fieldset>
        <div class="layui-tab" lay-filter="steps-list" lay-allowclose="true">
            <ul class="layui-tab-title"></ul>
            <div class="layui-tab-content"></div>
        </div>
        <div class="layui-card-body">
            <div class="layui-btn-group" style="float:right">
                <button class="layui-hide" lay-submit lay-filter="testList"></button>
                <button class="layui-btn" data-event="testList">测试</button>
                <button class="layui-btn" data-event="testListLog"><i class="layui-icon layui-icon-log"></i></button>
                <button class="layui-hide" lay-submit lay-filter="sourceCode"></button>
                <button class="layui-btn" data-event="sourceCode">源码</button>
            </div>
        </div>
    </div>
    <div>
        <fieldset class="layui-elem-field layui-field-title" style="margin-top:0;">
            <legend><i class="layui-icon layui-icon-add-circle" id="add-detail" data-event="addDetail"></i>新增规则
            </legend>
        </fieldset>
        <div class="layui-tab" lay-filter="steps-detail" lay-allowclose="true">
            <ul class="layui-tab-title"></ul>
            <div class="layui-tab-content"></div>
        </div>
        <div class="layui-card-body">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <div class="parse-method">
                        <div class="layui-inline">
                            <label for="next_dom" class="layui-form-label-col" lay-tips="DOM匹配下一篇文章URL">NextLink:</label>
                        </div>
                        <div class="layui-inline" style="width: 280px">
                            <input class="layui-input" type="text" autocomplete="off" name="next_dom" id="next_dom" value="{{.obj.NextDom}}" placeholder="div.next > a">
                        </div>
                        <div class="layui-inline" lay-tips="属性名称 默认为 href" style="width: 100px">
                            <input class="layui-input" type="text" autocomplete="off" name="next_attr_name" id="next_attr_name" value="{{.obj.NextAttrName}}" placeholder="href">
                        </div>
                        <div class="layui-inline">
                            <button class="layui-btn layui-btn-radius" data-event="regMethod">转为正则解析</button>
                        </div>
                    </div>
                    <div class="parse-method" style="display:none;">
                        <div class="layui-inline">
                            <label for="next_reg" class="layui-form-label-col" lay-tips="正则匹配下一篇文章URL">NextLink:</label>
                        </div>
                        <div class="layui-inline" style="width: 390px">
                            <input class="layui-input" type="text" autocomplete="off" name="next_reg" id="next_reg" value="{{.obj.NextReg}}" placeholder="<a href='(.*?)'">
                        </div>
                        <div class="layui-inline">
                            <button class="layui-btn layui-btn-radius" data-event="domMethod">转为DOM解析</button>
                        </div>
                    </div>
                </div>
                <div class="layui-inline" style="float: right">
                    <div class="layui-btn-group">
                        <button class="layui-hide" lay-submit lay-filter="testDetail"></button>
                        <button class="layui-btn" data-event="testDetail">测试</button>
                        <button class="layui-btn" data-event="testDetailLog"><i class="layui-icon layui-icon-log"></i>
                        </button>
                        <button class="layui-btn" data-event="sourceCode">源码</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div>
        <fieldset class="layui-elem-field">
            <legend>定时采集</legend>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">绑定网站:</label>
                    <div class="layui-input-block">
                        <select name="site_id" lay-filter="site_id" lay-search>
                            <option value="">搜索...</option>
                            {{range .sites -}}
                                <option value="{{.Id}}"{{if eq .Id $.obj.SiteId}} selected{{end}}>{{.Vhost}}</option>
                            {{end -}}
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label for="cron_enabled" class="layui-form-label">绑定栏目:</label>
                    <div class="layui-input-block" lay-filter="class_id">
                        {{.class_html}}
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label for="cron_enabled" class="layui-form-label">启用定时:</label>
                    <div class="layui-input-inline">
                        <input type="checkbox" name="cron_enabled" id="cron_enabled" lay-skin="switch" lay-text="是|否"
                                {{if .obj.CronEnabled}} checked{{end}}>
                    </div>
                </div>
                <div class="layui-inline">
                    <label for="spec" class="layui-form-label">Spec:</label>
                    <div class="layui-input-inline" lay-tips="双击修改定时任务">
                        <input type="text" autocomplete="off" name="spec" id="spec" value="{{.obj.Spec}}" class="layui-input">
                    </div>
                </div>
            </div>
        </fieldset>
    </div>
    <button class="layui-hide" lay-submit lay-filter="stepsSubmit"></button>
</div>
<input id="config" type="hidden">
<script>
    $('#config').val(JSON.stringify({
        engines:{{.engines}}, // 翻译引擎列表
        trans:{{.obj.Trans}}, // 翻译列表
        rules:{{.obj.List}}, // 列表规则
        details: {{.obj.Detail}}, // 详情
    }));
</script>