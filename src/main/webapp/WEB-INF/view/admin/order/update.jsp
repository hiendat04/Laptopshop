<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
                    <meta name="author" content="Hỏi Dân IT" />
                    <title>Cập nhật đơn hàng</title>
                    <link href="/css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                </head>

                <body class="sb-nav-fixed">
                    <jsp:include page="../layout/header.jsp" />
                    <div id="layoutSidenav">
                        <jsp:include page="../layout/sidebar.jsp" />
                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid px-4">
                                    <h1 class="mt-4">Manage Products</h1>
                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item"><a href="/admin">Trang chủ</a></li>
                                        <li class="breadcrumb-item active"><a href="/admin/order">Đơn hàng</a></li>
                                        <li class="breadcrumb-item">Cập nhật</li>
                                    </ol>
                                    <div class="mt-5">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <h3>Cập nhật đơn hàng</h3>
                                            <hr />
                                            <form:form method="post" action="/admin/order/update/${order.id}"
                                                modelAttribute="order" class="row g-3" enctype="multipart/form-data">
                                                <div class="col-12 col-md-6">
                                                    <p>ID: ${id}</p>
                                                </div>
                                                <div class="col-12 col-md-6">
                                                    <p>Price:
                                                        <fmt:formatNumber value="${order.totalPrice}" />
                                                        đ
                                                    </p>
                                                </div>
                                                <div class="col-12 col-md-6">
                                                    <label for="user" class="form-label">User:</label>
                                                    <input type="text" class="form-control" value="fullName" readonly />
                                                </div>
                                                <div class="col-12 col-md-6">
                                                    <label class="form-label">Status:</label>
                                                    <form:select class="form-select" path="status">
                                                        <form:option value="PENDING">PENDING</form:option>
                                                        <form:option value="SHIPPING">SHIPPING</form:option>
                                                        <form:option value="COMPLETED">COMPLETED</form:option>
                                                        <form:option value="CANCELED">CANCELED</form:option>
                                                    </form:select>
                                                </div>
                                                <div class="col-12 mb-5">
                                                    <button type="submit" class="btn btn-primary">Update</button>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </main>
                            <jsp:include page="../layout/footer.jsp" />
                        </div>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                        crossorigin="anonymous"></script>
                    <script src="/js/scripts.js"></script>
                </body>

                </html>