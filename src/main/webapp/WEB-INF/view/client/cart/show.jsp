<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                                        <th scope="col">Xử lý</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${empty cartDetails}">
                                        <div class="my-2 mb-5">Bạn chưa mua sản phẩm nào! Mua sản phẩm <a
                                                href="/">tại
                                                đây</a></div>
                                    </c:if>
                                    <c:if test="${not empty cartDetails}">
                                        <c:set var="totalPrice" value="0" />
                                        <c:forEach var="cartDetail" items="${cartDetails}">
                                            <tr>
                                                <c:set var="subTotal"
                                                    value="${cartDetail.product.price * cartDetail.quantity}" />
                                                <c:set var="totalPrice" value="${totalPrice = totalPrice + subTotal}" />
                                                <th scope="row">
                                                    <div class="d-flex align-cartDetails-center">
                                                        <img src="images/product/${cartDetail.product.image}"
                                                            class="img-fluid me-5 rounded-circle"
                                                            style="width: 80px; height: 80px;" alt="">
                                                    </div>
                                                </th>
                                                <td>
                                                    <a class="mb-0 mt-4" href="/product/${cartDetail.product.id}"
                                                        target="_blank">${cartDetail.product.name}</a>
                                                </td>
                                                <td>
                                                    <p class="mb-0 mt-4">
                                                        <fmt:formatNumber value="${cartDetail.product.price}" />
                                                    </p>
                                                </td>
                                                <td>
                                                    <div class="input-group quantity mt-4" style="width: 100px;">
                                                        <div class="input-group-btn">
                                                            <button
                                                                class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                                <i class="fa fa-minus"></i>
                                                            </button>
                                                        </div>
                                                        <input type="text"
                                                            class="form-control form-control-sm text-center border-0"
                                                            value="${cartDetail.quantity}"
                                                            data-cart-detail-id="${cartDetail.id}"
                                                            data-cart-detail-price="${cartDetail.price}">
                                                        <div class="input-group-btn">
                                                            <button
                                                                class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                                <i class="fa fa-plus"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <p class="mb-0 mt-4" data-cart-detail-id="${cartDetail.id}">
                                                        <fmt:formatNumber type="number" value="${subTotal}" />
                                                    </p>

                                                </td>
                                                <td>
                                                    <form method="post" action="/delete-cart-product/${cartDetail.id}">
                                                        <input type="hidden" name="${_csrf.parameterName}"
                                                            value="${_csrf.token}" />
                                                        <button class="btn btn-md rounded-circle bg-light border mt-4">
                                                            <i class="fa fa-times text-danger"></i>
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                        <c:if test="${not empty cartDetails}">
                            <div class="row g-4 justify-content-start">
                                <div class="col-8"></div>
                                <div class="col-12 col-md-8">
                                    <div class="bg-light rounded">
                                        <div class="p-4">
                                            <h1 class="display-6 mb-4">Cart <span class="fw-normal">Total</span></h1>
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
                                        <div class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                            <h5 class="mb-0 ps-4 me-4">Tổng số tiền</h5>
                                            <p class="mb-0 pe-4" data-cart-total-price="${totalPrice}">
                                                <fmt:formatNumber type="number" value="${totalPrice}" />
                                            </p>
                                        </div>
                                        <button
                                            class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4"
                                            type="button">Proceed Checkout</button>
                                    </div>
                                </div>
                            </div>
                        </c:if>
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