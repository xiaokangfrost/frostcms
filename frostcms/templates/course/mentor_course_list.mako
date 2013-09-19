<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>ccms</title>
    <%include file="/unit/link_JS&CSS.mako" />
</head>

<body>
	<!-- 导航栏部分 -->
    <%include file="/unit/nav.mako" />
    <!-- 主体部分 -->
	<div class="right">
    	
        <!-- 主体头部 -->
		<div class="right_head">
			<div class="title_2">课程管理</div>
			<form action="/mentor/course/list" class="search" name="college" method="post">
				按学期查询
				<select name="semesterid" size="1" onchange= "document.all.college.submit();">
					<option disabled="disabled" selected="selected" >--------请选择学期--------</option>
					% for li in lis:
					<option value="${li.id}" >${li.name}</option>
					% endfor
				</select>
			</form>
			<a class="btn btn-primary" id="btn_head" href="/mentor/course/add"><i class="icon-plus icon-white"></i> 添加课程</a> 
		</div>
        
        <!-- 主体信息表 -->
        <div class="right_main">
        	<table class="table table-bordered table-hover" id="main_table">
            <thead>
      			<tr>     
        			<th class="name">课程</th>
        			<!--<th class="name">教师</th>-->
        			<th class="name">学期</th>
        			<th class="app">操作</th>
      			</tr>
    		</thead>
            <tbody>
      			% for item in items:
      			<tr>
        			<td class="name">${item.name}</td>
        			<!--<td class="name">${item.mentor.name}</td>-->
        			<td class="name">
        			% for li in lis :
        				% if item.semesterid == li.id :
        				${li.name}
        				% endif
        			% endfor 
        			</td>
        			<td class="app">
        				<a class="btn btn-info btn-mini" href="/mentor/course/add?courseid=${item.id}">编辑</a>
        				<a class="btn btn-info btn-mini" href="/mentor/lesson/listbycourse?courseid=${item.id}">课堂安排</a>
        				<a class="btn btn-danger btn-mini" href="/mentor/course/del?courseid=${item.id}">删除</a>
        			</td>
      			</tr>
      			% endfor
    		</tbody>
            </table>
            <!-- 分页导航 -->         
        	<%include file="/unit/pagination.mako" />
        </div>               
        
    </div>
	<!-- 登录模块 -->
    <%include file="/login/login.mako" />
</body>
</html>