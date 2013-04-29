<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>ccms</title>
    <link href="../../static/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="../../static/css/ccms.css" rel="stylesheet" media="screen">
    <script src="../../static/js/bootstrap.js"></script>
</head>

<body>
	<!-- 登录模块 -->
    <%include file="/main/login.mako" />
	<!-- 顶部固定栏 -->
    <%include file="/main/head.mako" />
	<!-- 导航栏部分 -->
    <%include file="/main/nav_admin.mako" />
    <!-- 主体部分 -->
	<div class="right">
    	
        <!-- 主体头部 -->
		<div class="right_head">
			<div class="title_2">学生信息管理</div>
            
            <div class="search">
				<form class="search" action="/student/list" method="post">
				<input type="text" name="search_identity" class="input-medium search-query" autocomplete="off" value="" />
				<input type="submit" name="submit" class="btn" autocomplete="off" value="按学号查询" />
				</form>
			</div>	
			<button class="btn btn-info btn-primary" id="btn_head">添加新学生</button>
			<button class="btn btn-info btn-primary" id="btn_head">从xls文件导入</button>
            
		</div>
        
        <!-- 主体信息表 -->
        <div class="right_main">
        	<table class="table table-bordered table-hover" id="main_table">
            <thead>
      			<tr>
        			<th class="number">编号</th>        
        			<th class="name">姓名</th>
        			<th class="stdn">学号</th>
        			<th class="app">操作</th>
      			</tr>
    		</thead>
            <tbody>
      			% for item in items:
      			<tr>
        			<td class="number">${item.id}</td>
        			<td class="name">${item.name}</td>
        			<td class="stdn">${item.identity}</td>
        			<td class="app"><a href="/student/add?mentorid=${item.id}">修改学生信息</a></td>
      			</tr>
      			% endfor
    		</tbody>
            </table>
            <div class="right_foot">
            	<div class="pagination">
                <ul>
          	 		% if items.first_page:
	          		<li><a href="?page=${items.first_page}" title="第一页">&laquo; 第一页</a></li>
	         		% endif
	         		 % if items.previous_page:
	          		<li><a href="?page=${items.previous_page}" title="上一页">&laquo; 上一页</a></li>
	          		% endif
	         		% for i in range(items.page - 3,items.page):
			  		% if items.page_count>0 and i>=items.first_page:
					<a href="?page=${i}" class="number" title="${i}">${i}</a></li>
					% endif
			  		% endfor
	          		<li><a href="#" class="number current" title="${items.page}">${items.page}</a></li> 
	          		% for i in range(items.page+1, items.page + 3):
			  			% if items.page_count>0 and i<=items.last_page:
						<a href="?page=${i}" class="number" title="${i}"> ${i} </a></li>
			  			% endif
			 		% endfor
			  		% if items.next_page:
			  		<li><a href="?page=${items.next_page}" title="下一页">下一页 &raquo;</a></li>
			  		% endif
			  		% if items.last_page:
	          		<li><a href="?page=${items.last_page}" title="最后一页">最后一页 &raquo;</a></li> 
	          		% endif
          		</ul>
            	</div>
            </div>
        </div>               
        
    </div>
</body>
</html>