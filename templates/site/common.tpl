<style>
    #theme > img {
        max-width: 80px;
        max-height: 80px;
    }

    #theme > img:hover {
        max-width: 200px;
        max-height: 200px;
        cursor: pointer;
    }
</style>
<div class="layui-card" id="site">
    <div class="layui-card-body">
        <div class="layui-tab layui-tab-card layui-form">
            <ul class="layui-tab-title">
                <li class="layui-this">建站设置</li>
                <li>web设置</li>
                <li>手机站</li>
                <li>基本控制</li>
                <li>发布设置</li>
                <li>SEO设置</li>
                <li>设置更多选项</li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label for="system" class="layui-form-label">网站类型:</label>
                            <div class="layui-input-block">
                                <select name="system" id="system" lay-filter="system" {{if gt .obj.Status 0}} disabled{{end}}>
                                    {{range .drivers -}}
                                        <option value="{{.Driver}}" {{if eq $.obj.System .Driver}} selected{{end}}>{{.Alias}}</option>
                                    {{end -}}
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label for="vhost" class="layui-form-label">选择模板:</label>
                            <div class="layui-input-block" lay-filter="tpl_name">
                                {{.tpl_select}}
                            </div>
                        </div>
                        <div class="layui-inline" id="theme">
                            {{if .theme.Face -}}
                                <img width="100%" height="100%" alt="{{.theme.Alias}}" src="/file/download?filename={{.theme.SmallFace}}" data-src="{{.theme.Face}}" title="{{.theme.Readme}}">
                            {{end -}}
                        </div>
                        <div class="layui-inline">
                            <a lay-href="/themes/shop?driver={{.obj.System}}" class="layui-btn layui-btn-radius" id="theme-shop"><i class="layui-icon iconfont icon-shop"></i>主题商店</a>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label for="vhost" class="layui-form-label">站点域名<i class="iconfont icon-about" lay-tips="不带http://，创建后不可修改"></i>:</label>
                            <div class="layui-input-inline">
                                <input type="text" autocomplete="off" name="vhost" id="vhost" required lay-verify="vhost"
                                       class="layui-input" placeholder="如:botadmin.cn" autofocus="autofocus"
                                       value="{{.obj.Vhost}}" {{if gt .obj.Status 0}} disabled{{end}}>
                            </div>
                            <div class="layui-form-mid layui-word-aux">
                                <span class="text-danger" style="color:red;">*</span>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label for="binds" class="layui-form-label">绑定域名<i class="iconfont icon-about" lay-tips="多个请用英文逗号,分隔"></i>:</label>
                            <div class="layui-input-block">
                                <input type="text" autocomplete="off" name="binds" id="binds" class="layui-input" placeholder="如:blog.botadmin.cn,nfivf.com" value='{{join .obj.Binds ","}}'>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label for="indexes" class="layui-form-label">默认首页:</label>
                        <div class="layui-input-inline">
                            <input type="text" name="indexes" id="indexes" class="layui-input" value="{{join .obj.Indexes ","}}"
                                   autocomplete="on" placeholder="index.html,index.php">
                        </div>
                        <div class="layui-form-mid layui-word-aux">留空为默认值，多个用英文逗号","分隔</div>
                    </div>
                    <div class="layui-form-item">
                        <label for="ssl" class="layui-form-label">https支持:</label>
                        <div class="layui-input-inline">
                            <select name="ssl" id="ssl" {{if gt .obj.Status 0}} disabled{{end}}>
                                <option value="0" {{if eq .obj.Ssl 0}} selected{{end}}>不启用</option>
                                <option value="1" {{if eq .obj.Ssl 1}} selected{{end}}>启用</option>
                                <option value="2" {{if eq .obj.Ssl 2}} selected{{end}}>强制启用</option>
                            </select>
                        </div>
                        <div class="layui-form-mid layui-word-aux">开启需要有SSL证书文件，否则无效。可后台创建或
                            <a lay-href="/file?path={{.ssl_path}}" class="text-danger">自行上传</a>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label for="unlimited_bind" class="layui-form-label">泛域名<i class="iconfont icon-about" lay-tips="对泛域名的支持，一般不需要开启"></i>:</label>
                        <div class="layui-input-inline">
                            <input type="checkbox" name="unlimited_bind" id="unlimited_bind" lay-skin="switch"
                                   lay-text="启用|禁用"{{if .obj.UnlimitedBind}} checked{{end}}>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label for="sql_enabled" class="layui-form-label">SQL<i class="iconfont icon-about" lay-tips="是否启用数据库，如果启用又不选择则自动创建"></i>:</label>
                            <div class="layui-input-block">
                                <input type="checkbox" name="sql_enabled" id="sql_enabled" lay-skin="switch" lay-text="启用|禁用"{{if .obj.SqlEnabled}} checked{{end}}>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <select name="sql_id" id="sql_id" lay-tips="不选择则自动创建数据库" lay-search>
                                <option value="">自动创建</option>
                                {{range .sqls -}}
                                    <option value="{{.Id}}" {{if eq .Id $.obj.SqlId}} selected{{end}}>{{.Dbname}}</option>
                                {{end -}}
                            </select>
                        </div>
                        <div class="layui-inline">
                            <div class="layui-form-mid layui-word-aux">不选择则自动创建数据库</div>
                            <div class="layui-btn layui-btn-primary" data-event="addSql">手动创建数据库</div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label for="ftp_enabled" class="layui-form-label">FTP<i class="iconfont icon-about" lay-tips="是否启用FTP，如果启用又不选择则自动创建"></i>:</label>
                            <div class="layui-input-block">
                                <input type="checkbox" name="ftp_enabled" id="ftp_enabled" lay-skin="switch" lay-text="启用|禁用"{{if .obj.FtpEnabled}} checked{{end}}>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <select name="ftp_id" id="ftp_id" lay-search>
                                <option value="">自动创建</option>
                                {{range .ftps -}}
                                    <option value="{{.Id}}" {{if eq .Id $.obj.FtpId}} selected{{end}}>{{.Username}}</option>
                                {{end -}}
                            </select>
                        </div>
                        <div class="layui-inline">
                            <div class="layui-form-mid layui-word-aux">不选择则自动创建FTP</div>
                            <div class="layui-btn layui-btn-primary" data-event="addFtp">手动创建FTP</div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">状态:</label>
                        <div class="layui-input-inline">
                            <select name="status" class="layui-select">
                                {{range .status}}
                                    <option value="{{.Index}}" {{if eq $.obj.Status .Index}} selected{{end}}>{{.Alias}}</option>
                                {{end}}
                            </select>
                        </div>
                        <div class="layui-form-mid layui-word-aux">外部站只允许发布文章</div>
                    </div>
                </div>
                <div class="layui-tab-item">
                    <fieldset class="layui-elem-field">
                        <legend>后台登录</legend>
                        <div class="layui-form-item">
                            <div class="layui-row">
                                <div class="layui-col-sm6">
                                    <label for="web_user" class="layui-form-label" lay-tips="由3-15个字母或数字组成">用户名:</label>
                                    <div class="layui-input-block">
                                        <input type="text" autocomplete="off" name="web_user" id="web_user" value="{{.obj.WebUser}}"
                                               class="layui-input" placeholder="3-15个字符">
                                    </div>
                                </div>
                                <div class="layui-col-sm5">
                                    <label for="web_pwd" class="layui-form-label" lay-tips="由6-15个字符组成">密码:</label>
                                    <div class="layui-input-block">
                                        <input type="text" autocomplete="off" name="web_pwd" id="web_pwd" value="{{.obj.WebPwd}}"
                                               class="layui-input" placeholder="6-15个字符">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                    <fieldset class="layui-elem-field">
                        <legend>后台设置</legend>
                        <div class="layui-form-item">
                            <div class="layui-row layui-col-space10">
                                <div class="layui-col-sm5">
                                    <label for="title" class="layui-form-label" lay-tips="主标题，如:广州南方39助孕网">首页标题:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="title" id="title" value="{{.obj.Title}}" class="layui-input"
                                               autocomplete="off" placeholder="广州南方39助孕网">
                                    </div>
                                </div>
                                <div class="layui-col-sm1">
                                    <button class="layui-btn layui-btn-radius" data-event="valid_title">验证合规
                                    </button>
                                </div>
                                <div class="layui-col-sm4">
                                    <label for="subtitle" class="layui-form-label" lay-tips="每个网页的标题后缀 如:南方39助孕网">副标题:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="subtitle" id="subtitle" value="{{.obj.Subtitle}}"
                                               autocomplete="off" class="layui-input" placeholder="39助孕网">
                                    </div>
                                </div>
                                <div class="layui-col-sm1">
                                    <button class="layui-btn layui-btn-radius" data-event="valid_title_suffix">验证合规
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-row">
                                <div class="layui-col-sm6">
                                    <label for="keywords" class="layui-form-label" lay-tips="多个关键词用英文逗号,隔开">关键词:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="keywords" id="keywords" value='{{join .obj.Keywords ","}}'
                                               autocomplete="off" class="layui-input" placeholder="关键词1,关键词2">
                                    </div>
                                </div>
                                <div class="layui-col-sm5">
                                    <label for="description" class="layui-form-label">Tags:</label>
                                    <div class="layui-input-block">
                                        <textarea name="tags" class="layui-textarea" placeholder="TAG 一行一个">{{join .obj.Tags "\n"}}</textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-row layui-col-space10">
                                <div class="layui-col-sm10">
                                    <label for="description" class="layui-form-label" lay-tips="用80-120个字符描述网站">描述:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="description" id="description" value="{{.obj.Description}}"
                                               autocomplete="off" class="layui-input" placeholder="网站描述">
                                    </div>
                                </div>
                                <div class="layui-col-sm1">
                                    <button class="layui-btn layui-btn-radius" data-event="valid_description">验证合规
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">栏目列表:</label>
                            <input type="hidden" name="classes" value="{{print .obj.Classes }}" required lay-verify="classes">
                            <div class="layui-input-block" id="classes-tree"></div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-row">
                                <div class="layui-col-sm6">
                                    <label class="layui-form-label" lay-tips="网站后台登录认证码 15个字母或数字组成">认证码:</label>
                                    <div class="layui-input-inline">
                                        <input type="text" autocomplete="off" name="auth_code" id="auth_code" value="{{.obj.AuthCode}}" data-type="fill" class="layui-input" placeholder="登录第二验证码">
                                    </div>
                                </div>
                                <div class="layui-col-sm5">
                                    <label for="admin_dir" class="layui-form-label" lay-tips="网站后台登录目录名称">后台目录:</label>
                                    <div class="layui-input-block">
                                        <input type="text" autocomplete="off" name="admin_dir" id="admin_dir" class="layui-input"
                                               value="{{.obj.AdminDir}}" placeholder="nfivf">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-row">
                                <div class="layui-col-sm6">
                                    <label for="class_num" class="layui-form-label" lay-tips="一般栏目数量设置不超过10个">栏目数量:</label>
                                    <div class="layui-input-block">
                                        <input type="text" autocomplete="off" name="class_num" id="class_num" class="layui-input"
                                               value="{{.obj.ClassNum}}" placeholder="8">
                                    </div>
                                </div>
                                <div class="layui-col-sm5">
                                    <label for="city" class="layui-form-label" lay-tips="选择城市必须是实际存在的">城市:</label>
                                    <div class="layui-input-block">
                                        <select name="city" id="city" lay-search>
                                            <option value="">直接选择或搜索选择</option>
                                            <option value="random">随机城市</option>
                                            {{range .cities -}}
                                                <option value="{{.}}" {{if eq . $.obj.City}} selected{{end}}>{{.}}</option>
                                            {{end -}}
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-row">
                                <div class="layui-col-sm6">
                                    <label for="wap_enabled" class="layui-form-label" lay-tips="网站广告代码一般为js代码">广告:</label>
                                    <div class="layui-input-block">
                                        <textarea name="ad" class="layui-textarea" placeholder="网站广告代码一般为js代码">{{.obj.Ad}}</textarea>
                                    </div>
                                </div>
                                <div class="layui-col-md6">
                                    <label for="wap_enabled" class="layui-form-label">版权:</label>
                                    <div class="layui-input-block">
                                        <textarea name="copyright" class="layui-textarea" placeholder="©版权所有：站掌门 公安备案:xxxxxx号 网站ICP备案：xxxxxx号 未经授权禁止转载、摘编、复制或建立镜像，如有违发，追究法律责任！">{{.obj.Copyright}}</textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-col-sm6">
                                <label for="wap_enabled" class="layui-form-label" lay-tips="李谊:139-2235-2985 一行一条">联系方式:</label>
                                <div class="layui-input-block">
                                    <textarea name="contact" class="layui-textarea" placeholder="李谊:139-2235-2985&#13;韩晶:135-3983-5229">{{join .obj.Contact "\n"}}</textarea>
                                </div>
                            </div>
                            <div class="layui-col-sm6">
                                <label for="wap_enabled" class="layui-form-label" lay-tips="灰词=>替换成的是词 一行一条">灰词替换:</label>
                                <div class="layui-input-block">
                                    <textarea name="replaces" class="layui-textarea" placeholder="小姐=>美女&#13;代孕=>怀孕">{{join .obj.Replaces "\n"}}</textarea>
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="wap_enabled" class="layui-form-label">关于我们:</label>
                            <div class="layui-input-block">
                                <textarea name="about" class="layui-textarea" placeholder="站群cms系统,单站站群,支持批量发布,批量处理,建站养站自动采集站群管理系统,全自动批量操作,可批量采集英中互译,优化内容,统一管理模式,提供完整的解决方案,一人轻松管理数百个网站">{{.obj.About}}</textarea>
                            </div>
                        </div>
                    </fieldset>
                </div>
                <div class="layui-tab-item">
                    <div class="layui-form-item">
                        <label for="wap_enabled" class="layui-form-label">手机站:</label>
                        <div class="layui-input-inline">
                            <input type="checkbox" name="wap_enabled" id="wap_enabled" lay-skin="switch"
                                   lay-text="是|否" {{if .obj.WapEnabled}} checked{{end}}>
                        </div>
                        <div class="layui-form-mid layui-word-aux"><span class="text-danger">创建手机站</span></div>
                    </div>
                    <div class="layui-form-item">
                        <label for="wap_host" class="layui-form-label">手机域名:</label>
                        <div class="layui-input-inline">
                            <input type="text" autocomplete="off" name="wap_host" id="wap_host" value="{{.obj.WapHost}}"
                                   placeholder="如:m.webrobot.cn" class="layui-input">
                        </div>
                        <div class="layui-form-mid layui-word-aux">请确定域名已经解析到服务器ip</div>
                    </div>
                    <div class="layui-form-item">
                        <label for="wap_root_dir" class="layui-form-label">路径名:</label>
                        <div class="layui-input-inline">
                            <input type="text" name="wap_root_dir" id="wap_root_dir" class="layui-input" value="{{.obj.WapRootDir}}"
                                   autocomplete="off" placeholder="m">
                        </div>
                        <div class="layui-form-mid layui-word-aux">确保网站根目录下存在这个路径</div>
                    </div>
                </div>
                <div class="layui-tab-item">
                    <fieldset class="layui-elem-field">
                        <legend>错误提示页</legend>
                        <div class="layui-form-item">
                            <label for="err400" class="layui-form-label"></label>
                            <input name="err400" id="err400" type="checkbox" title="400" {{if .obj.Err400}} checked{{end}}/>
                            <input name="err401" id="err401" type="checkbox" title="401" {{if .obj.Err401}} checked{{end}}/>
                            <input name="err403" id="err403" type="checkbox" title="403" {{if .obj.Err403}} checked{{end}}/>
                            <input name="err404" id="err404" type="checkbox" title="404" {{if .obj.Err404}} checked{{end}}/>
                            <input name="err405" id="err405" type="checkbox" title="405" {{if .obj.Err405}} checked{{end}}/>
                            <input name="err500" id="err500" type="checkbox" title="500" {{if .obj.Err500}} checked{{end}}/>
                            <input name="err503" id="err503" type="checkbox" title="503" {{if .obj.Err503}} checked{{end}}/>
                        </div>
                    </fieldset>
                    <fieldset class="layui-elem-field">
                        <legend>301/302跳转</legend>
                        <div class="layui-form-item">
                            <label for="err400" class="layui-form-label"></label>
                            <div class="layui-input-inline">
                                <select name="redirects" id="redirects">
                                    <option value="0" {{if eq .obj.Redirects 0}} selected{{end}}>不启用
                                    </option>
                                    <option value="301" {{if eq .obj.Redirects 301}} selected{{end}}>301跳转
                                    </option>
                                    <option value="302" {{if eq .obj.Redirects 302}} selected{{end}}>302跳转
                                    </option>
                                </select>
                            </div>
                            <div class="layui-input-inline">
                                <input type="text" autocomplete="off" name="redirects_url" id="redirects_url" value="{{.obj.RedirectsUrl}}"
                                       class="layui-input" placeholder="http://www.botadmin.cn">
                            </div>
                            <div class="layui-form-mid layui-word-aux">跳转URL，如: http://www.webrobot.cn</div>
                        </div>
                    </fieldset>
                    <fieldset class="layui-elem-field">
                        <legend>网站日志</legend>
                        <div class="layui-form-item">
                            <label for="access_log" class="layui-form-label"></label>
                            <div class="layui-inline">
                                <input type="checkbox" name="access_log" id="access_log"
                                       title="Access" {{if .obj.AccessLog}} checked{{end}}>
                                <input type="checkbox" name="error_log" id="error_log"
                                       title="Error" {{if .obj.ErrorLog}} checked{{end}}>
                            </div>
                            <div class="layui-inline">
                                <div class="layui-form-mid layui-word-aux">
                                    记录详细的访问日志，会占服务器资源，如无特别需求，不建议开启
                                </div>
                            </div>
                        </div>
                    </fieldset>
                    <fieldset class="layui-elem-field">
                        <legend>网站安全</legend>
                        <div class="layui-form-item">
                            <label for="limit_dir" class="layui-form-label"></label>
                            <div class="layui-inline">
                                <input type="checkbox" name="limit_dir" id="limit_dir"
                                       title="限制跨目录" {{if .obj.LimitDir}} checked{{end}}>
                                <input type="checkbox" name="display_dir" id="display_dir"
                                       title="列举目录" {{if .obj.DisplayDir}} checked{{end}}>
                            </div>
                            <div class="layui-inline">
                                <div class="layui-form-mid layui-word-aux">
                                    防止webshell跨目录跨站和没有默认首页时显示所有文件列表
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="safe_img_type" class="layui-form-label">防盗链类型</label>
                            <div class="layui-input-block">
                                <input type="text" autocomplete="off" name="safe_img_type" id="safe_img_type" value="{{.obj.SafeImgType}}"
                                       class="layui-input" placeholder="jpg,gif,bmp">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="allow_domains" class="layui-form-label">允许的域名</label>
                            <div class="layui-input-block">
                                <input type="text" autocomplete="off" name="allow_domains" id="allow_domains" value="{{.obj.AllowDomains}}"
                                       class="layui-input" placeholder="botadmin.cn,nfivf.com">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="safe_img_src" class="layui-form-label">盗链URL</label>
                            <div class="layui-input-block">
                                <input type="text" autocomplete="off" name="safe_img_src" id="safe_img_src" value="{{.obj.SafeImgSrc}}"
                                       class="layui-input" placeholder="http://www.webrobot.cn/images/logo.png">
                            </div>
                        </div>
                    </fieldset>
                    <fieldset class="layui-elem-field">
                        <legend>站点设置</legend>
                        <div class="layui-form-item">
                            <label for="web_gzip" class="layui-form-label">gzip压缩</label>
                            <div class="layui-input-inline">
                                <input type="checkbox" name="web_gzip" id="web_gzip" lay-skin="switch"
                                       lay-text="是|否" {{if .obj.WebGzip}} checked{{end}}>
                            </div>
                            <div class="layui-form-mid layui-word-aux">此功能为可将部分网页压缩传输，可以节省带宽</div>
                        </div>
                        <div class="layui-form-item">
                            <label for="client_cache" class="layui-form-label">客户端缓存</label>
                            <div class="layui-input-inline">
                                <input type="checkbox" name="client_cache" id="client_cache" lay-skin="switch"
                                       lay-text="是|否" {{if .obj.ClientCache}} checked{{end}}>
                            </div>
                            <div class="layui-form-mid layui-word-aux">
                                此功能可减轻服务器负载，但有时更新可能不会及时显示
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="del_site_all" class="layui-form-label">删除站点</label>
                            <div class="layui-input-inline">
                                <input type="checkbox" name="del_site_all" id="del_site_all" lay-skin="switch"
                                       lay-text="是|否" {{if .obj.DelSiteAll}} checked{{end}}>
                            </div>
                            <div class="layui-form-mid layui-word-aux">删除站点时是否删除目录和数据</div>
                        </div>
                        <div class="layui-form-item">
                            <label for="del_ftp_all" class="layui-form-label">删除ftp</label>
                            <div class="layui-input-inline">
                                <input type="checkbox" name="del_ftp_all" id="del_ftp_all" lay-skin="switch"
                                       lay-text="是|否" {{if .obj.DelFtpAll}} checked{{end}}>
                            </div>
                            <div class="layui-form-mid layui-word-aux">删除ftp用户时是否删除目录及数据</div>
                        </div>
                        <div class="layui-form-item">
                            <label for="city_enabled" class="layui-form-label">随机城市</label>
                            <div class="layui-input-inline">
                                <input type="checkbox" name="city_enabled" id="city_enabled" lay-skin="switch"
                                       lay-text="是|否" {{if .obj.CityEnabled}} checked{{end}}>
                            </div>
                            <div class="layui-form-mid layui-word-aux">开启或者关闭随机城市选择</div>
                        </div>
                    </fieldset>
                </div>
                <div class="layui-tab-item">
                    <div class="layui-form-item layui-row">
                        <div class="layui-col-sm6">
                            <label for="publish_mode" class="layui-form-label">发布模式:</label>
                            <div class="layui-input-block">
                                <select name="publish_mode" id="publish_mode" class="layui-select">
                                    <option value="0"{{if eq .obj.PublishMode 0}} selected{{end}}>正常模式</option>
                                    <option value="1"{{if eq .obj.PublishMode 1}} selected{{end}}>百科模式</option>
                                    <option value="2"{{if eq .obj.PublishMode 2}} selected{{end}}>随机模式</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-col-sm6">
                            <label class="layui-form-label" lay-tips="随机发布指定数量的文章">发布阈值:</label>
                            <div class="layui-input-block">
                                <div id="pub_deg" class="slider-block"></div>
                                <input type="hidden" name="pub_deg" value="{{print .obj.PubDeg}}"/>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-row">
                            <div class="layui-col-md6">
                                <label for="pic_dir" class="layui-form-label">标题格式:</label>
                                <div class="layui-input-inline">
                                    <textarea name="title_formats" rows="3" class="layui-textarea">{{join .obj.TitleFormats "\n"}}</textarea>
                                </div>
                                <div class="layui-form-mid layui-word-aux">
                                    标签: &#123;&#123;tag&#125;&#125; &#123;&#123;title&#125;&#125; <br/>一行一条
                                </div>
                            </div>
                            <div class="layui-col-md6">
                                <label for="pic_dir" class="layui-form-label">随机词汇:</label>
                                <div class="layui-input-inline">
                                    <textarea name="words" class="layui-textarea">{{join .obj.Words "\n"}}</textarea>
                                </div>
                                <div class="layui-form-mid layui-word-aux">
                                    百科模式所用到的随机词汇<br/>留空则使用资料库的<a lay-href="/config/site/data" style="color:green">随机词库</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-row">
                            <div class="layui-col-md6">
                                <label for="pic_dir" class="layui-form-label">图片路径:</label>
                                <div class="layui-input-inline">
                                    <input type="text" autocomplete="off" name="pic_dir" id="pic_dir" value="{{.obj.PicDir}}" class="layui-input"/>
                                </div>
                                <div class="layui-form-mid layui-word-aux">
                                    <a lay-href="/file?path=data/pic/{{.obj.PicDir}}" lay-text="默认图片">点击添加或删除图片</a>
                                </div>
                            </div>
                            <div class="layui-col-md6">
                                <label for="pub_interval" class="layui-form-label">发布间隔:</label>
                                <div class="layui-input-inline">
                                    <input type="number" autocomplete="off" min="100" name="pub_interval" id="pub_interval" value="{{.obj.PubInterval}}" class="layui-input"/>
                                </div>
                                <div class="layui-form-mid layui-word-aux">单位为毫秒</div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item layui-row">
                        <div class="layui-col-md2">
                            <label for="pic_autoed" class="layui-form-label" lay-tips="系统根据标题和描述自动制作图片">自动图片:</label>
                            <div class="layui-input-block">
                                <input type="checkbox" name="pic_autoed" id="pic_autoed" lay-skin="switch" lay-text="是|否"{{if .obj.PicAutoed}} checked{{end}}>
                            </div>
                        </div>
                        <div class="layui-col-md3">
                            <label for="pic_w" class="layui-form-label" lay-tips="自动生成图片的宽度">自动图宽:</label>
                            <div class="layui-input-block">
                                <input type="number" autocomplete="off" name="pic_w" id="pic_w" value="{{.obj.PicW}}" class="layui-input"/>
                            </div>
                        </div>
                        <div class="layui-col-md3">
                            <label for="pic_h" class="layui-form-label" lay-tips="自动生成图片的高度">自动图高:</label>
                            <div class="layui-input-block">
                                <input type="number" autocomplete="off" name="pic_h" id="pic_h" value="{{.obj.PicH}}" class="layui-input"/>
                            </div>
                        </div>
                        <div class="layui-col-md3">
                            <label for="pic_mode" class="layui-form-label" lay-tips="自动生成图片的高">图模式:</label>
                            <div class="layui-input-block">
                                <select name="pic_mode" id="pic_mode" class="layui-select">
                                    <option value="0"{{if eq .obj.PicMode 0}} selected{{end}}>随机颜色</option>
                                    <option value="1"{{if eq .obj.PicMode 1}} selected{{end}}>白底黑字</option>
                                    <option value="2"{{if eq .obj.PicMode 2}} selected{{end}}>黑底白字</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-row">
                            <div class="layui-col-md6">
                                <label class="layui-form-label">插图阈值:</label>
                                <div class="layui-input-inline">
                                    <div id="insert_pic_deg" class="slider-inline"></div>
                                    <input type="hidden" name="insert_pic_deg" value="{{print .obj.InsertPicDeg}}"/>
                                </div>
                                <div class="layui-form-mid layui-word-aux">随机插入图片数量</div>
                            </div>
                            <div class="layui-col-md6">
                                <label class="layui-form-label">内容阈值:</label>
                                <div class="layui-input-inline">
                                    <div id="content_deg" class="slider-inline"></div>
                                    <input type="hidden" name="content_deg" value="{{print .obj.ContentDeg}}"/>
                                </div>
                                <div class="layui-form-mid layui-word-aux">内容内随机插入关键词数量</div>
                            </div>
                            <div class="layui-col-md6">
                                <label class="layui-form-label">原创度:</label>
                                <div class="layui-input-inline">
                                    <div id="originality_rate" class="slider-inline"></div>
                                    <input type="hidden" name="originality_rate" value="{{$.obj.OriginalityRate}}">
                                </div>
                                <div class="layui-form-mid layui-word-aux">大于或等于这个值才发布</div>
                            </div>
                            <div class="layui-col-md6">
                                <label class="layui-form-label">属性阀值:</label>
                                <div class="layui-input-inline">
                                    <div id="pub_attr_deg" class="slider-inline"></div>
                                    <input type="hidden" name="pub_attr_deg" value="{{$.obj.PubAttrDeg}}">
                                </div>
                                <div class="layui-form-mid layui-word-aux">值越高 几率越高</div>
                            </div>
                            <div class="layui-col-md6">
                                <label class="layui-form-label">内链阀值:</label>
                                <div class="layui-input-inline">
                                    <div id="link_deg" class="slider-inline"></div>
                                    <input type="hidden" name="link_deg" value="{{$.obj.LinkDeg}}">
                                </div>
                                <div class="layui-form-mid layui-word-aux">随机插入内链</div>
                            </div>
                            <div class="layui-col-md6">
                                <label class="layui-form-label">外链阀值:</label>
                                <div class="layui-input-inline">
                                    <div id="out_link_deg" class="slider-inline"></div>
                                    <input type="hidden" name="out_link_deg" value="{{$.obj.OutLinkDeg}}">
                                </div>
                                <div class="layui-form-mid layui-word-aux">随机插入外链</div>
                            </div>
                            <div class="layui-col-md6">
                                <label class="layui-form-label">标题阀值:</label>
                                <div class="layui-input-inline">
                                    <div id="title_tag_deg" class="slider-inline"></div>
                                    <input type="hidden" name="title_tag_deg" value="{{$.obj.TitleTagDeg}}">
                                </div>
                                <div class="layui-form-mid layui-word-aux">标题插入tag 值越高 几率越高</div>
                            </div>
                            <div class="layui-col-md6">
                                <label for="pub_self" class="layui-form-label">指定:</label>
                                <div class="layui-input-inline">
                                    <input type="checkbox" name="pub_self" id="pub_self" lay-skin="switch"
                                           lay-text="是|否" {{if .obj.PubSelf}} checked{{end}}>
                                </div>
                                <div class="layui-form-mid layui-word-aux">只发布指定本站的文章</div>
                            </div>
                            <div class="layui-col-md6">
                                <label for="pic_save" class="layui-form-label">保存图片:</label>
                                <div class="layui-input-inline">
                                    <input type="checkbox" name="pic_save" id="pic_save" lay-skin="switch" lay-text="是|否"{{if .obj.PicSave}} checked{{end}}>
                                </div>
                                <div class="layui-form-mid layui-word-aux">是否保存远程图片</div>
                            </div>
                            <div class="layui-col-md6">
                                <label for="pic_mark" class="layui-form-label">图片水印:</label>
                                <div class="layui-input-inline">
                                    <input type="checkbox" name="pic_mark" id="pic_mark" lay-skin="switch" lay-text="是|否"{{if .obj.PicMark}} checked{{end}}>
                                </div>
                                <div class="layui-form-mid layui-word-aux">图片是否加水印</div>
                            </div>
                            <div class="layui-col-md6">
                                <label for="del_published" class="layui-form-label">删除已发:</label>
                                <div class="layui-input-inline">
                                    <input type="checkbox" name="del_published" id="del_published" lay-skin="switch"
                                           lay-text="是|否" {{if .obj.DelPublished}} checked{{end}}>
                                </div>
                                <div class="layui-form-mid layui-word-aux">发布后马上从数据库中删除该文章</div>
                            </div>
                            <div class="layui-col-md6">
                                <label for="order" class="layui-form-label">发布顺序:</label>
                                <div class="layui-input-inline">
                                    <select name="order" id="order" class="layui-select">
                                        <option value="0"{{if eq .obj.Order 0}} selected{{end}}>最新采集</option>
                                        <option value="1"{{if eq .obj.Order 1}} selected{{end}}>最旧采集</option>
                                        <option value="2"{{if eq .obj.Order 2}} selected{{end}}>随机</option>
                                    </select>
                                </div>
                                <div class="layui-form-mid layui-word-aux">发布文章顺序</div>
                            </div>
                        </div>
                    </div>
                    <fieldset class="layui-elem-field">
                        <legend>推送</legend>
                        <div class="layui-form-item" style="padding-left: 2%;padding-right: 2%;">
                            <textarea name="push_config" class="layui-textarea" rows="3"
                                      placeholder="http://data.zz.baidu.com/urls?site=&#123;&#123;site&#125;&#125;&token=zjoYZiTU6B1rgblL 百度普通推送 账号=username 密码=password">{{.push_config}}</textarea>
                        </div>
                    </fieldset>
                    <fieldset class="layui-elem-field">
                        <legend>定时发布</legend>
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label for="cron_enabled" class="layui-form-label">启用:</label>
                                <div class="layui-input-inline">
                                    <input type="checkbox" name="cron_enabled" id="cron_enabled" lay-skin="switch" lay-text="是|否" {{if .obj.CronEnabled}} checked{{end}}>
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
                <div class="layui-tab-item">
                    <div class="layui-row">
                        <div class="layui-col-md6">
                            <div class="layui-form-item">
                                <label for="scan_enabled" class="layui-form-label" lay-tips="登录百度后的cookies">百度
                                    Cookies:</label>
                                <div class="layui-input-block">
                                    <textarea name="bd_cookies" class="layui-textarea" rows="3"
                                              placeholder="BAIDUID=9FB739ED7E70EF8247B81415058BCB64:FG=1; PSTM=1620359085; PSINO=6; BD_CK_SAM=1; delPer=0; BIDUPSID=5296CC5C149D53A3462999AA795C8824; BAIDUID_BFESS=9FB739ED7E70EF8247B81415058BCB64:FG=1; COOKIE_SESSION=0_0_0_0_1_0_0_0_0_0_0_0_0_0_2_0_1620359088_0_1620359086%7C1%230_0_1620359086%7C1; H_PS_PSSID=33985_33820_31253_34004_33756_33676_33607_26350_33996; BD_UPN=12314753; BDORZ=B490B5EBF6F3CD402E515D22BCDA1598; BDUSS_BFESS=25VMmJwNzhLMTlGb3FTeE01Wk9jd3N-QUJhaGlLc2ZuTktxU1ZwaC02VkN3cjVnSVFBQUFBJCQAAAAAAAAAAAEAAADCjSYT2vfPzc6wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEI1l2BCNZdgU; BDUSS=25VMmJwNzhLMTlGb3FTeE01Wk9jd3N-QUJhaGlLc2ZuTktxU1ZwaC02VkN3cjVnSVFBQUFBJCQAAAAAAAAAAAEAAADCjSYT2vfPzc6wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEI1l2BCNZdgU; sugstore=1; H_PS_645EC=9350iLs1RL31aIit5ml8QCIhe79p5iPmI8yBGI1Dgr768BQf7SW%2Btb1IoTo; BA_HECTOR=a100ah20al2k21a0181g9edaf0r; WWW_ST=1620522324302">{{.obj.BdCookies}}</textarea>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item">
                                <label for="scan_enabled" class="layui-form-label" lay-tips="忽略百度关键词列表">过滤:</label>
                                <div class="layui-input-block">
                                    <textarea name="bd_ignores" class="layui-textarea" rows="3" placeholder="小姐&#13;代孕">{{ join .obj.BdIgnores "\n"}}</textarea>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item">
                                <label for="scan_enabled" class="layui-form-label"
                                       lay-tips="内链列表 关键词=>URL 例如：试管婴儿=>http://www.botadmin.cn/">内链列表:</label>
                                <div class="layui-input-block">
                            <textarea name="links" class="layui-textarea" rows="5"
                                      placeholder="试管婴儿=>http://www.nfivf.com/&#13;站掌门=>http://www.botadmin.cn/">{{.obj.Links}}</textarea>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item">
                                <label for="scan_enabled" class="layui-form-label"
                                       lay-tips="外链列表 关键词=>URL 例如：试管婴儿=>http://www.botadmin.cn/">外链列表:</label>
                                <div class="layui-input-block">
                                    <textarea name="out_links" class="layui-textarea" rows="5"
                                              placeholder="试管婴儿=>http://www.nfivf.com/&#13;站掌门=>http://www.botadmin.cn/">{{.obj.OutLinks}}</textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-tab-item">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label for="scan_enabled" class="layui-form-label">扫描病毒<i class="iconfont icon-about" lay-tips="根据定时规则启动对网站文件定时扫描"></i>:</label>
                            <div class="layui-input-inline">
                                <input type="checkbox" name="scan_enabled" id="scan_enabled" lay-skin="switch" lay-text="启用|禁用" title="启用|禁用"{{if .obj.ScanEnabled}} checked{{end}}>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label for="scan_spec" class="layui-form-label">定时规则<i class="iconfont icon-about" lay-tips="定时扫描,默认为每天扫描一次，双击修改定时任务"></i>:</label>
                            <div class="layui-input-inline">
                                <input type="text" autocomplete="off" name="scan_spec" id="scan_spec" value="{{.obj.ScanSpec}}" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label for="rewrite" class="layui-form-label">Rewrite:</label>
                        <div class="layui-input-inline">
                            <select name="rewrite" id="rewrite" lay-search>
                                <option value="">搜索...</option>
                                {{range .rewrites -}}
                                    <option value="{{.}}" {{if eq . $.obj.Rewrite}} selected{{end}}>{{.}}</option>
                                {{end -}}
                            </select>
                        </div>
                        <div class="layui-form-mid layui-word-aux">如不知道或无使用，
                            <a lay-href="/file?path={{.rewrite_path}}"
                               lay-text="Rewrite管理" style="color: #0a93bf"><strong>Rewrite管理</strong></a>。也可以使用.htaccess格式，上传到网站根目录(public_html)下
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label for="port" class="layui-form-label">使用端口:</label>
                        <div class="layui-input-inline">
                            <input type="number" autocomplete="off" name="port" id="port" value="{{.obj.Port}}" class="layui-input" placeholder="80">
                        </div>
                        <div class="layui-form-mid layui-word-aux">
                            只在需要使用非80端口时使用，否则请使用默认值。可在系统设置里设置或增加端口
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label for="ip_addr" class="layui-form-label">使用IP:</label>
                        <div class="layui-input-inline">
                            <select name="ip_addr" id="ip_addr" lay-search>
                                <option value="">搜索...</option>
                                {{range .ips}}
                                    <option value="{{.}}" {{if eq $.obj.IpAddr .}} selected{{end}}>{{.}}</option>
                                {{end}}
                            </select>
                        </div>
                        <div class="layui-form-mid layui-word-aux">
                            此功能只在多IP且要域名指定IP时用，否则请留默认值。可在系统设置里设置或增加IP
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label for="conn" class="layui-form-label">IP并发数:</label>
                        <div class="layui-input-inline">
                            <input type="number" autocomplete="off" name="conn" id="conn" class="layui-input" value="{{.obj.Conn}}" placeholder="0">
                        </div>
                        <div class="layui-form-mid layui-word-aux">每IP的并发连接数 默认为0，即不限制</div>
                    </div>
                    <div class="layui-form-item">
                        <label for="conn_speed" class="layui-form-label">线程速度:</label>
                        <div class="layui-input-inline">
                            <input type="number" autocomplete="off" name="conn_speed" id="conn_speed" class="layui-input" value="{{.obj.ConnSpeed}}" placeholder="0">
                        </div>
                        <div class="layui-form-mid layui-word-aux">默认为0，即不限制 每个连接线程的速度，单位KB/S</div>
                    </div>
                    <div class="layui-form-item">
                        <label for="others" class="layui-form-label" lay-tips="需要标准的json格式">其他配置:</label>
                        <div class="layui-input-block">
                            <textarea name="others" id="others" class="layui-textarea" rows="7" placeholder="{&quot;tag_limit&quot;:10,&quot;tag_show&quot;:0}">{{print .obj.Others }}</textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-form-item layui-hide">
                <div class="layui-input-block">
                    <input type="hidden" name="id" value="{{.obj.Id}}">
                    <button class="layui-btn" lay-submit lay-filter="submit">提交</button>
                    <div class="layui-hide" data-class-names="{{json .class_names}}"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    layui.use(['main', 'classes'], function () {
        let main = layui.main,
            form = layui.form;
        // 渲染栏目列表
        layui.classes();
        // 渲染模板
        main.render.theme();
        // 自动填充
        main.render.fill();
        // 定时选择器
        main.cron('input[name=spec]', 'input[name=scan_spec]');
        let getVhost = function () {
                let ele = $('#site input[name=vhost]');
                if (!new RegExp(/^(?:[a-zA-Z\d-]+\.)+[a-zA-Z]/).test(ele.val())) {
                    main.error('必须是一个有效的域名', {
                        end: function () {
                            $('#site').scrollTop(0);
                            ele.focus()
                        }
                    });
                    return false;
                }
                return ele.val();
            },
            active = {
                addSql: function () {
                    let vhost = getVhost();
                    if (vhost) {
                        main.get('/sql/add', {dbname: vhost}, function (html) {
                            main.popup({
                                title: "添加SQL",
                                url: '/sql/add',
                                content: html,
                                area: ['600px', '600px'],
                                done: function () {
                                    main.get('/sql/list').done(function (res) {
                                        if (Array.isArray(res.data)) {
                                            let ele = $('#site select[name=sql_id]'),
                                                sqlId = +ele.val(),
                                                id = +($('#site input[name=id]').val()),
                                                enabled = $('#site [name=sql_enabled]').prop('checked'),
                                                html = '<option value="">自动创建</option>';
                                            $.each(res.data, function (i, v) {
                                                if ((enabled && id === 0 && i === 0) || v.id === sqlId) {
                                                    html += '<option value="' + v.id + '" selected>' + v.dbname + '</option>';
                                                } else {
                                                    html += '<option value="' + v.id + '">' + v.dbname + '</option>';
                                                }
                                            });
                                            ele.html(html);
                                            form.render('select');
                                        }
                                    });
                                }
                            });
                        });
                    }
                },
                addFtp: function () {
                    let vhost = getVhost();
                    if (vhost) {

                        main.get('/ftp/add', {username: vhost}, function (html) {
                            main.popup({
                                title: "添加FTP",
                                url: '/ftp/add',
                                content: html,
                                area: ['600px', '600px'],
                                done: function () {
                                    main.get('/ftp/list').done(function (res) {
                                        if (Array.isArray(res.data)) {
                                            let ele = $('#site select[name=ftp_id]'),
                                                ftpId = +ele.val(),
                                                id = +($('#site input[name=id]').val()),
                                                enabled = $('#site [name=ftp_enabled]').prop('checked'),
                                                html = '<option value="">自动创建</option>';
                                            $.each(res.data, function (i, v) {
                                                if ((enabled && id === 0 && i === 0) || v.id === ftpId) {
                                                    html += '<option value="' + v.id + '" selected>' + v.username + '</option>';
                                                } else {
                                                    html += '<option value="' + v.id + '">' + v.username + '</option>';
                                                }
                                            });
                                            ele.html(html);
                                            form.render('select');
                                        }
                                    });
                                }
                            });
                        });
                    }
                },
            };
        $('[data-event]').off('click').on('click', function () {
            let $this = $(this), event = $this.data('event');
            active[event] && active[event].call($this);
        });
        //滑块控制
        main.slider(
            {elem: '#insert_pic_deg', range: true},
            {elem: '#pub_deg', range: true, min: 1, max: 100},
            {elem: '#content_deg', range: true},
            {elem: '#pub_attr_deg', value: {{$.obj.PubAttrDeg}}},
            {elem: '#originality_rate', value: {{$.obj.OriginalityRate}}, max: 100},
            {elem: '#link_deg', value: {{$.obj.LinkDeg}}},
            {elem: '#out_link_deg', value: {{$.obj.OutLinkDeg}}},
            {elem: '#title_tag_deg', value: {{$.obj.TitleTagDeg}}},
        );
        /* 验证 */
        form.verify({
            vhost: function (val) {
                if (!new RegExp(/^(?:[a-zA-Z\d-]+\.)+[a-zA-Z]/).test(val)) {
                    $('.layui-tab>.layui-tab-title>li:nth-child(1)').click();
                    return '必须是一个有效的域名';
                }
            },
            classes: function (val) {
                if (!new RegExp(/^\[[\s\S]+]$/).test(val)) {
                    $('.layui-tab>.layui-tab-title>li:nth-child(2)').click();
                    return '请设置网站栏目列表';
                }
            },
        });
    });
</script>