<div class="layui-card-body layui-form">
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
			<label for="id" class="layui-form-label">绑定栏目:</label>
			<div class="layui-input-block" lay-filter="class_id">
                {{.class_html}}
			</div>
		</div>
		<div class="layui-hide">
			<input name="id" id="id" value="{{.obj.Id}}">
			<button class="layui-btn" lay-submit lay-filter="submit"></button>
		</div>
	</div>
</div>
<script>
	layui.use([], function () {
		let $ = layui.$,
			form = layui.form,
			main = layui.main,
			classes = {},
			bindClass = function (id, classId) {
				if (isNaN(parseInt(id))) {
					$('select[name=class_id]').replaceWith(`<select name="class_id" id="class_id" lay-search><option value="">搜索...</option></select>`);
					form.render('select');
					return false
				}
				if (typeof classes[id] === 'string' && classes[id].length > 10) {
					$('[lay-filter=class_id]').html(classes[id]);
					form.render();
					return false;
				}

				main.get('/site/class', {id: id, class_id: classId}, function (res) {

					if (res.code === 0) {
						classes[id] = res.data;
						$('[lay-filter=class_id]').html(res.data);
						form.render();
					} else {
						main.error(res.msg);
					}
				});
			};
		//监控选择网站ID
		form.on('select(site_id)', function (obj) {
			bindClass(obj.value);
		});
	});
</script>