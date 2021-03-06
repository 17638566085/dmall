<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link id="favicon" href="http://www.easyicon.net/api/resizeApi.php?id=1188709&size=128" rel="icon" type="image/x-icon"/>
<base href="${pageContext.request.contextPath }/">
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/js/deliverOrders.js"></script>
<link href="resources/css/standard.css" rel="stylesheet">
<title>处理用户订单</title>
</head>
<body>
	<div id="wrapper">
		<div class="container-fluid">
			<!-- navgation -->
			<div class="row">
				<nav class="navbar navbar-fixed-top navbar-inverse "> 
					<div class="navbar-header">
						<a class="navbar-brand">DMALL 地猫商城</a>
						<button class="navbar-toggle" data-toggle="collapse" data-target="#collapseMenu">
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
					</div>

					<div class="collapse navbar-collapse" id="collapseMenu">
						<ul class="nav navbar-nav">
							<li>
								<a href="product">
									<span class="glyphicon glyphicon-apple">所有商品</span>
								</a>
							</li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<li class="dropdown">
								<a class="dropdown-toggle" data-toggle="dropdown">
									${admin.username }<strong class="caret"></strong>
								</a>
								<ul class="dropdown-menu">
									<li><a href="admin/order"><span class="glyphicon glyphicon-th-list"></span>订单处理</a></li>
									<li><a href="admin/purchase"><span class="glyphicon glyphicon-pushpin"></span>采购管理</a></li>
									<li><a href="admin/receive"><span class="glyphicon glyphicon-import"></span>入库管理</a></li>
									<li class="divider"></li>
									<li><a href="admin/offline"><span class="glyphicon glyphicon-off"></span>退出登录</a></li>
								</ul>
							</li>
						</ul>
					</div>					
				</nav>
			</div>
			
			<div id="page-wrapper">
			
				<div class="col-md-6 col-md-offset-3 col-xs-12">
					
					<div>
						<img alt="pic" id="titleImg" src="resources/img/dmall2.png">
						
						<div class="pull-right">
							<h4>待处理用户订单</h4>
						</div>
 					</div>
					
					<c:choose>
						<c:when test="${empty orders }">
							<div id="nullTip" class="alert alert-warning">
								<span>待处理用户订单为空ʅ(‾◡◝)ʃ</span>
							</div>
						</c:when>
						<c:otherwise>
							<c:forEach items="${orders }" var="order" varStatus="st">
								<table class="table table-striped table-bordered">
									<caption>
										订单编号：<span>${order.orderId }</span>
										客户编号：<span>${order.client.clientId }</span>
										下单时间：<span><fmt:formatDate value="${order.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
										订单总价：<span>${order.doublePrice }</span>
									</caption>
									<thead>
										<tr>
											<th>订单项编号</th>
											<th>商品编号</th>
											<th>商品名称</th>
											<th>商品数量</th>
											<th>库存数量</th>
											<th>缺件数量</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${order.orderItems }" var="orderItem">
											<tr>
												<td>${orderItem.orderItemId }</td>
												<td>${orderItem.product.productId }</td>
												<td>${orderItem.product.productName }</td>
												<td>${orderItem.productQuantity }</td>
												<td>${orderItem.product.storage }</td>
												<%-- 若商品数量大于库存，显示缺件数，否则显示0 --%>
												<td>${orderItem.product.storage > 
														orderItem.productQuantity ? 
														0 : orderItem.productQuantity - orderItem.product.storage }</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<button id="${order.orderId }" class="btn btn-primary pull-right deliverBtn">确认发货</button>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
				
				<div id="deliverModal" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title">提示</h4>
							</div>
							<div class="modal-body"><span class="lead"></span></div>
							<div class="modal-footer">
								<a href="admin/order" type="button" class="btn btn-primary">确定</a>
							</div>
						</div>
					</div>
				</div>
				
			</div>	<!-- page-wrapper -->
			
		</div>	<!-- container -->
	</div>	<!-- wrapper -->
</body>
</html>