<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <title>Cart</title>
                    <meta content="width=device-width, initial-scale=1.0" name="viewport">
                    <meta content="" name="keywords">
                    <meta content="" name="description">

                    <!-- Google Web Fonts -->
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                        rel="stylesheet">

                    <!-- Icon Font Stylesheet -->
                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet">

                    <!-- Libraries Stylesheet -->
                    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


                    <!-- Customized Bootstrap Stylesheet -->
                    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                    <!-- Template Stylesheet -->
                    <link href="/client/css/style.css" rel="stylesheet">
                </head>

                <body>

                    <jsp:include page="../layout/header.jsp" />

                    <!-- Cart Page Start -->
                    <div class="container-fluid py-5">
                        <div class="container py-5">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Chi tiết giỏ hàng</li>
                                </ol>
                            </nav>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">Sản phẩm</th>
                                            <th scope="col">Tên</th>
                                            <th scope="col">Giá cả</th>
                                            <th scope="col">Số lượng</th>
                                            <th scope="col">Thành tiền</th>
                                            <th scope="col">Trạng thái</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty orders}">
                                            <div class="my-2 mb-5">Bạn chưa mua sản phẩm nào! Mua sản phẩm <a
                                                    href="/">tại
                                                    đây</a></div>
                                        </c:if>
                                        <c:if test="${not empty orders}">
                                            <c:forEach var="order" items="${orders}">
                                                <tr>
                                                    <td>Order Id : ${order.id}</td>
                                                    <td></td>
                                                    <td>
                                                        <fmt:formatNumber value="${order.totalPrice}" /> đ
                                                    </td>
                                                    <td></td>
                                                    <td></td>
                                                    <td>${order.status}</td>
                                                    <c:forEach var="orderDetail" items="${order.orderDetails}">
                                                <tr>
                                                    <th scope="row">
                                                        <div class="d-flex align-cartDetails-center">
                                                            <img src="images/product/${orderDetail.product.image}"
                                                                class="img-fluid me-5 rounded-circle"
                                                                style="width: 80px; height: 80px;" alt="">
                                                        </div>
                                                    </th>
                                                    <td>
                                                        <div class="mb-0 mt-4">
                                                            <a href="/product/${orderDetail.product.id}"
                                                                target="_blank">${orderDetail.product.name}</a>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <p class="mb-0 mt-4">
                                                            <fmt:formatNumber value="${orderDetail.product.price}" />
                                                        </p>
                                                    </td>
                                                    <td>
                                                        <div class="mb-0 mt-4">
                                                            ${orderDetail.quantity}
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="mb-0 mt-4">
                                                            <fmt:formatNumber
                                                                value="${orderDetail.quantity * orderDetail.price}" /> đ
                                                        </div>
                                                    </td>
                                                    <td></td>
                                                </tr>
                                            </c:forEach>
                                            </tr>
                                            </c:forEach>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                            <!-- <c:if test="${not empty cartDetails}">
                                <div class="row g-4 justify-content-start">
                                    <div class="col-8"></div>
                                    <div class="col-12 col-md-8">
                                        <div class="bg-light rounded">
                                            <div class="p-4">
                                                <h1 class="display-6 mb-4">Cart <span class="fw-normal">Total</span>
                                                </h1>
                                                <div class="d-flex justify-content-between mb-4">
                                                    <h5 class="mb-0 me-4">Tạm tính:</h5>
                                                    <p class="mb-0" data-cart-total-price="${totalPrice}">
                                                        <fmt:formatNumber type="number" value="${totalPrice}" />
                                                    </p>
                                                </div>
                                                <div class="d-flex justify-content-between">
                                                    <h5 class="mb-0 me-4">Phí vận chuyển</h5>
                                                    <div class="">
                                                        <p class="mb-0">0</p>
                                                    </div>
                                                </div>
                                                <p class="mb-0 text-end">Vận chuyển nội thành.</p>
                                            </div>
                                            <div
                                                class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                                <h5 class="mb-0 ps-4 me-4">Tổng số tiền</h5>
                                                <p class="mb-0 pe-4" data-cart-total-price="${totalPrice}">
                                                    <fmt:formatNumber type="number" value="${totalPrice}" />
                                                </p>
                                            </div>
                                            <form:form action="/confirm-checkout" method="get" modelAttribute="cart">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
                                                <div style="display: none;">
                                                    <c:forEach var="cartDetail" items="${cart.cartDetails}"
                                                        varStatus="status">
                                                        <div class="mb-3">
                                                            <div class="form-group">
                                                                <label>Id:</label>
                                                                <form:input class="form-control" type="text"
                                                                    value="${cartDetail.id}"
                                                                    path="cartDetails[${status.index}].id" />
                                                            </div>
                                                            <div class="form-group">
                                                                <label>Quantity:</label>
                                                                <form:input class="form-control" type="text"
                                                                    value="${cartDetail.quantity}"
                                                                    path="cartDetails[${status.index}].quantity" />
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                                <button
                                                    class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4">Xác
                                                    nhận thanh toán
                                                </button>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </c:if> -->
                        </div>
                    </div>
                    <!-- Cart Page End -->

                    <jsp:include page="../layout/footer.jsp" />

                    <!-- Back to Top -->
                    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                            class="fa fa-arrow-up"></i></a>


                    <!-- JavaScript Libraries -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/lib/easing/easing.min.js"></script>
                    <script src="/client/lib/waypoints/waypoints.min.js"></script>
                    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
                    <!-- Template Javascript -->
                    <script src="/client/js/main.js"></script>
                </body>

                </html>