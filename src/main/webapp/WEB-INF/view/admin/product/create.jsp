<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
                <meta name="author" content="Hỏi Dân IT" />
                <title>Create User</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script>
                    $(document).ready(() => {
                        const avatarFile = $("#productImageFile");
                        avatarFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#productPreview").attr("src", imgURL);
                            $("#productPreview").css({ "display": "block" });
                        });
                    });
                </script>
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
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item active">Product</li>
                                </ol>
                                <div class="mt-5">
                                    <div class="col-md-6 col-12 mx-auto">
                                        <h3>Create a product</h3>
                                        <hr />
                                        <form:form method="post" action="/admin/product/create"
                                            modelAttribute="newProduct" class="row g-3" enctype="multipart/form-data">
                                            <div class="col-12 col-md-6">
                                                <label for="name" class="form-label">Name:</label>
                                                <c:set var="nameError">
                                                    <form:errors path="name" cssClass="invalid-feedback" />
                                                </c:set>
                                                <form:input type="text"
                                                    class="form-control ${not empty nameError ? 'is-invalid' : ''}"
                                                    path="name" />
                                                ${nameError}
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label for="price" class="form-label">Price:</label>
                                                <c:set var="priceError">
                                                    <form:errors path="price" cssClass="invalid-feedback" />
                                                </c:set>
                                                <form:input type="number"
                                                    class="form-control ${not empty nameError ? 'is-invalid' : ''}"
                                                    path="price" />
                                                ${priceError}
                                            </div>
                                            <div class="col-12">
                                                <label for="detailDesc" class="form-label">Detail Description:</label>
                                                <c:set var="detailError">
                                                    <form:errors path="detailDesc" cssClass="invalid-feedback" />
                                                </c:set>
                                                <form:textarea
                                                    class="form-control ${not empty nameError ? 'is-invalid' : ''}"
                                                    path="detailDesc" rows="3" />
                                                ${detailError}
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label for="shortDesc" class="form-label">Short Description:</label>
                                                <c:set var="shortError">
                                                    <form:errors path="shortDesc" cssClass="invalid-feedback" />
                                                </c:set>
                                                <form:input type="text"
                                                    class="form-control ${not empty nameError ? 'is-invalid' : ''}"
                                                    path="shortDesc" />
                                                ${shortError}
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label for="quantity" class="form-label">Quantity:</label>
                                                <c:set var="quantityError">
                                                    <form:errors path="quantity" cssClass="invalid-feedback" />
                                                </c:set>
                                                <form:input type="number"
                                                    class="form-control ${not empty quantityError ? 'is-invalid' : ''}"
                                                    path="quantity" />
                                                ${quantityError}
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label class="form-label">Factory:</label>
                                                <form:select class="form-select" path="factory">
                                                    <form:option value="APPLE">Apple (Macbook)</form:option>
                                                    <form:option value="HP">HP</form:option>
                                                    <form:option value="ASUS">Asus</form:option>
                                                    <form:option value="LENOVO">Lenovo</form:option>
                                                    <form:option value="DELL">Dell</form:option>
                                                </form:select>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label class="form-label">Target:</label>
                                                <form:select class="form-select" path="target">
                                                    <form:option value="GAMING">Gaming</form:option>
                                                    <form:option value="SINHVIEN-VANPHONG">Sinh viên - văn phòng
                                                    </form:option>
                                                    <form:option value="THIET-KE-DO-HOA">Thiết kế đồ họa
                                                    </form:option>
                                                    <form:option value="MONG-NHE">Mỏng nhẹ</form:option>
                                                    <form:option value="DOANH-NHAN">Doanh nhân</form:option>
                                                </form:select>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label for="productImageFile" class="form-label">Image:</label>
                                                <input class="form-control" type="file" id="productImageFile"
                                                    accept=".png, .jpg, .jpeg" name="uploadFile" />
                                            </div>
                                            <div class="col-12 mb-3">
                                                <img style="max-height: 250px; display: none;" alt="product preview"
                                                    id="productPreview">
                                            </div>
                                            <div class="col-12 mb-5">
                                                <button type="submit" class="btn btn-primary">Create</button>
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
                <script src="js/scripts.js"></script>
            </body>

            </html>