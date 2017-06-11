$(function() {
	
	// 一键入库点击事件
	$('.enterBtn').click(function() {
		var $row = $(this).parents('table').find('.valignTr');
		$row.each(function() {
			var purchaseNum = $(this).find('td:eq(3)').text();
			$(this).find('input').val(purchaseNum);
		});
	});
	
	// 校验入库数字
	function verifyNum(num, purchase) {
		var number = Number(num);
		var purchaseNum = Number(purchase);
		
		var reg = /^\d{1,}$/;
		if (!reg.test(number)) {
			return false;
		}
		
		if (number > purchaseNum || number < 0) {
			return false;
		}
		
		return true;
	}
	
	$('.confirmReceive').click(function() {
		var $table = $(this).siblings('table');
		var pId = $table.find('span:first').text();alert(pId)
		// 该订单的所有行
		var $row = $table.find('.valignTr');
		var rece = {};
		
		// 判断循环是否出错的标志
		var flag = true;
		$row.each(function() {
			var productId = $(this).find('td:eq(1)').prop('id');
			var purchase = $(this).find('td:eq(3)').text();
			var num = $(this).find('input').val();

			if (!verifyNum(num, purchase)) {
				$('#verifyTip').modal('show');
				flag = false;
				// 终止each循环
				return false;
			} else {
				rece[productId] = num;
			}
		});
		
		console.log(rece);
		
		if (flag) {
			$.ajax({
				url : 'admin/sendRece',
				data : {
					purchaseId : pId,
					rece : JSON.stringify(rece)
				},
				success : function() {
					alert('success');
				},
				error : function() {
					alert('获取请求失败，请稍后重试！');
					location.reload();
				}
			});
		}
	});
});