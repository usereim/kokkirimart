product_type1�� �Ѿ �� �ְ� value�� 1, 2, 3, 4�� ������


<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="euc-kr" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="goods" value="${goodsMap.goods}" />
<c:set var="imageFileList" value="${goodsMap.imageFileList}" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
.form{
margin: 0 auto;
width:1000px;
}

.btn-group-sm>.btn, .btn-sm {
    padding: 5px 10px;
    font-size: 14px;
    font-weight:500;
    line-height: 1.5;
    width: 60px;
    background: 50BCDF;
    border-radius: 3px;
}
.frm_mod_goods{
  width: 1000px;
  padding:30px;
  margin: 0 auto; 
  font-family: 'Noto Sans KR', sans-serif;
  border: 1px solid #E8E8E8;
  margin-top: 40px;
  margin-bottom: 40px;  
}

.frm_mod_tab{
  width: 1000px;
  padding:30px;
  margin: 0 auto; 
  font-family: 'Noto Sans KR', sans-serif;
  margin-top: 40px;
  margin-bottom: 40px;  
}

.category {display: flex;justify-content: center; }
.category a:hover img {opacity: 0.8; /* ���� ���� */transition: all 0.5s ease-in-out; /* ���� ȿ�� ���� */ transform: translateY(-10px);}

.table{
  width:100%;
  align-items: center;
  flex-direction: column;
  margin-top:20px;
  font-family: 'Noto Sans KR', sans-serif;
  border-collapse: separate; 

}

 .title{
  font-family: 'Noto Sans KR', sans-serif;
  text-align: center;
  font-size: 30px;
  font-weight: 700;
  margin-bottom: 40px;
 }
 
  td {
  border-top: 1px solid #ddd; /* ���ʿ� border �߰� */
  padding: 15px;
  vertical-align: middle;
}
.required {
    color: #DB0000; /* ���ϴ� �������� �����ϼ��� */
  }
.cancel-order-btn{
border:none;
height: 30px;
}  
 
 .hh2{
 text-align: center;
   margin-top: 50px;
   font-family: 'Noto Sans KR', sans-serif;
   font-weight: 700;
   font-size: 35px;
   margin-bottom: 20px;
 }

</style>


</HEAD>
<html>
<BODY>
   <div class="title" style="margin-top: 50px">
      <h3 class="hh2">��ǰ ����</h3>
   </div>

   <form name="frm_mod_goods" method=post>
      <DIV class="clear"></DIV>
      <!-- ���� ��� ���� �� -->

      <DIV class="frm_mod_tab" id="tab1">
         <table class="table">
            <tr>
               <td width=20% >��ǰ�з�</td>
               <td width=65%><select name="product_type1">
                     <c:choose>
                        <c:when test="${goods.product_type1=='1' }">
                           <option value="1" selected>��</option>
                           <option value="2">����</option>
                           <option value="3">��</option>
                           <option value="4">��ŰƮ/�����</option>
                        </c:when>
                        <c:when test="${goods.product_type1=='2' }">
                           <option value="COW" >��</option>
                           <option value="PIG" selected>����</option>
                           <option value="CHICKEN">��</option>
                           <option value="MEALKIT">��ŰƮ/�����</option>
                        </c:when>
                        <c:when test="${goods.product_type1=='3' }">
                           <option value="COW" >��</option>
                           <option value="PIG" >����</option>
                           <option value="CHICKEN" selected>��</option>
                           <option value="MEALKIT">��ŰƮ/�����</option>
                        </c:when>
                        <c:when test="${goods.product_type1=='4' }">
                           <option value="COW" >��</option>
                           <option value="PIG" >����</option>
                           <option value="CHICKEN" >��</option>
                           <option value="MEALKIT" selected>��ŰƮ/�����</option>
                        </c:when>
                     </c:choose>
               </select></td>
               <td width=15% ><input type="button" value="����"
                  class="btn btn-secondary btn-sm"
                  onClick="fn_modify_goods('${goods.product_id }','product_type1')" /></td>
            </tr>
            <tr>
               <td>��ǰ�̸�</td>
               <td><input name="goods_title" type="text" size="40"
                  value="${goods.product_name }" /></td>
               <td><input type="button" value="����"
                  class="btn btn-secondary btn-sm"
                  onClick="fn_modify_goods('${goods.product_id }','product_name')" /></td>
            </tr>

            <tr>

               <td>��ǰ�ǸŰ���</td>
               <td><input name="product_price" type="text" size="40"
                  value="${goods.product_price }" /></td>
               <td><input type="button" value="����"
                  class="btn btn-secondary btn-sm"
                  onClick="fn_modify_goods('${goods.product_id }','product_price')" /></td>
            </tr>


            <tr>
               <td>��ǰ�����</td>
               <td><input name="product_date" type="date"
                  value="${goods.product_date }" /></td>
               <td><input type="button" value="����"
                  class="btn btn-secondary btn-sm"
                  onClick="fn_modify_goods('${goods.product_id }','product_date')" />
               </td>
            </tr>

            <tr>
               <td>��ǰ�Ұ�</td>
               <td><textarea rows="8" cols="70" name="product_contents">${goods.product_contents }</textarea></td>
               <td>
               <input type="button" value="����" onClick="fn_modify_goods('${goods.product_id }','product_contents')"
                   class="btn btn-secondary btn-sm" />
               </td>
            </tr>
                 
				<tr>
				  <form id="FILE_FORM" method="post" enctype="multipart/form-data">		            
		             <c:forEach var="item" items="${imageFileList }" varStatus="itemNum">		                 
		                        <c:if test="${item.fileType=='main_image' }">
		                           <tr>
		                              <td>���� �̹���</td>
		                             
		                              <td><img id="preview${itemNum.count }" width=200 height=200 src="${contextPath}/thumbnails.do?product_id=${item.product_id}&fileName=${item.fileName}" />
					                    <input type="file" id="main_image" name="main_image" onchange="readURL(this,'preview${itemNum.count}');" /> 
					                    <input type="hidden" name="image_id" value="${item.image_id}" />            
		                              </td>		                            
		                              <td><input type="button" value="����"
		                                 onClick="modifyImageFile('main_image','${item.product_id}','${item.image_id}','${item.fileType}')"
		                                 class="btn btn-secondary btn-sm" /></td>
		                           </tr>
		                                  
		                    </c:if>
		             </c:forEach>  
		           </form>
                </tr>
                <tr style="text-align: right;s">
                  <td colspan="3">      
	                  <c:forEach var="item" items="${imageFileList }" varStatus="itemNum" begin="0" end="0">
			            <input type="button" value="����" class="btn btn-secondary btn-sm" onClick="deleteGoods('${goods.product_id}'), backToList(this.form)">
			          </c:forEach>
		          </td>
                </tr>
         </table>
      </DIV>
   		
         
         
         <!--  -->
      <DIV class="tab_content" id="tab7">
        
      </DIV>
      <DIV class="clear"></DIV>

   </form>
   
<%--    <c:choose>
   <c:when test='${not empty goods.goods_status}'>
      <script>
         window.onload = function() {
            init();
         }

         function init() {
            var frm_mod_goods = document.frm_mod_goods;
            var h_goods_status = frm_mod_goods.h_goods_status;
            var goods_status = h_goods_status.value;
            var select_goods_status = frm_mod_goods.goods_status;
            select_goods_status.value = goods_status;
         }
      </script>
   </c:when>
</c:choose> --%>

<script type="text/javascript">
   // ������ ��ǰ ������ �Ӽ��� ���� ���� ��Ʈ�ѷ��� �����մϴ�.
   function fn_modify_goods(product_id, attribute) {
      var frm_mod_goods = document.frm_mod_goods;
      var value = "";
      if (attribute == 'product_type1') {
         value = frm_mod_goods.product_type1.value;
      } else if (attribute == 'product_name') {
         value = frm_mod_goods.product_name.value;
      } else if (attribute == 'product_price') {
         value = frm_mod_goods.product_price.value;
      } else if (attribute == 'product_date') {
         value = frm_mod_goods.product_date.value;
      }

      $.ajax({
         type : "post",
         async : false, //false�� ��� ��������� ó���Ѵ�.
         url : "${contextPath}/admin/goods/modifyGoodsInfo.do",
         data : {
            product_id : product_id,
            // ��ǰ �Ӽ��� ���� ���� Ajax�� �����մϴ�.
            attribute : attribute,
            value : value
         },
         success : function(data, textStatus) {
            if (data.trim() == 'mod_success') {
               alert("��ǰ ������ �����߽��ϴ�.");
            } else if (data.trim() == 'failed') {
               alert("�ٽ� �õ��� �ּ���.");
            }

         },
         error : function(data, textStatus) {
            alert("������ �߻��߽��ϴ�." + data);
         },
         complete : function(data, textStatus) {
            //alert("�۾����Ϸ� �߽��ϴ�");

         }
      }); //end ajax   
   }

   function readURL(input, preview) {
      //  alert(preview);
      if (input.files && input.files[0]) {
         var reader = new FileReader();
         reader.onload = function(e) {
            $('#' + preview).attr('src', e.target.result);
         }
         reader.readAsDataURL(input.files[0]);
      }
   }

   // '�̹��� �߰�' Ŭ�� �� �� �̹��� ���� ���ε带 �߰��մϴ�.
   var cnt = 1;
   function fn_addFile() {
      $("#d_file").append(
            "<br>" + "<input  type='file' name='detail_image" + cnt
                  + "' id='detail_image" + cnt
                  + "'  onchange=readURL(this,'previewImage" + cnt
                  + "') />");
      $("#d_file").append(
            "<img  id='previewImage"+cnt+"'   width=200 height=200  />");
      $("#d_file")
            .append(
                  "<input  type='button' value='�߰�'  onClick=addNewImageFile('detail_image"
                        + cnt
                        + "','${imageFileList[0].product_id}','detail_image')  />");
      cnt++;
   }

   // ���� �̹����� �ٸ� �̹����� ������ �� FormData�� �̿��� Ajax�� �����մϴ�.
   function modifyImageFile(fileId, product_id, image_id, fileType) {
      // alert(fileId);
      var form = $('#FILE_FORM')[0];
      var formData = new FormData(form);

      // formData�� ������ �̹����� �̹��� ������ name/value�� �����մϴ�.
      formData.append("fileName", $('#' + fileId)[0].files[0]);
      formData.append("product_id", product_id);
      formData.append("image_id", image_id);
      formData.append("fileType", fileType);

      $.ajax({
         url : '${contextPath}/admin/goods/modifyGoodsImageInfo.do',
         processData : false,
         contentType : false,
         // formData�� Ajax�� �����մϴ�.
         data : formData,
         type : 'POST',
         success : function(result) {
            alert("�̹����� �����߽��ϴ�!");
         }
      });
   }

   // �� �̹��� �߰� �� FormData�� �̿��� Ajax�� �����մϴ�.
   function addNewImageFile(fileId, product_id, fileType) {
      //  alert(fileId);
      var form = $('#FILE_FORM')[0];
      var formData = new FormData(form);
      formData.append("uploadFile", $('#' + fileId)[0].files[0]);
      formData.append("product_id", product_id);
      formData.append("fileType", fileType);

      $.ajax({
         url : '${contextPath}/admin/goods/addNewGoodsImage.do',
         processData : false,
         contentType : false,
         data : formData,
         type : 'post',
         success : function(result) {
            alert("�̹����� �����߽��ϴ�!");
         }
      });
   }

   // �̹����� �����մϴ�.
   function deleteImageFile(product_id, image_id, imageFileName, trId) {
      var tr = document.getElementById(trId);

      $.ajax({
         type : "post",
         async : true, //false�� ��� ��������� ó���Ѵ�.
         url : "${contextPath}/admin/goods/removeGoodsImage.do",
         data : {
            product_id : product_id,
            image_id : image_id,
            imageFileName : imageFileName
         },
         success : function(data, textStatus) {
            alert("�̹����� �����߽��ϴ�.");
            tr.style.display = 'none';
         },
         error : function(data, textStatus) {
            alert("������ �߻��߽��ϴ�." + textStatus);
         },
         complete : function(data, textStatus) {
            //alert("�۾����Ϸ� �߽��ϴ�");

         }
      }); //end ajax   
   }

   /* ��ǰ���� */
   function deleteGoods(product_id) {
      $.ajax({
         type : "post",
         async : true,
         url : "${contextPath}/admin/goods/removeGoods.do",
         data : {
            product_id : product_id
         },
         success : function(data, textStatus) {
            alert("��ǰ�� �����߽��ϴ�.");
            location.href = "${contextPath}/admin/goods/adminGoodsMain.do";
         },
         error : function(data, textStatus) {
            alert("������ �߻��߽��ϴ�." + textStatus);
         },
         complete : function(data, textStatus) {
            //alert("�۾����Ϸ� �߽��ϴ�");
         }
      }); //end ajax
   }

   function backToList(obj) {
      obj.action = "${contextPath}/admin/goods/adminGoodsMain.do";
      obj.submit();
   }
</script>
   
 </BODY>
 </html>