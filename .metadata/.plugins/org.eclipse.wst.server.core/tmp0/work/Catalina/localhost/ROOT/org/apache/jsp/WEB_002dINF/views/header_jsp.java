/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.91
 * Generated at: 2023-10-10 07:59:28 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class header_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(2);
    _jspx_dependants.put("jar:file:/D:/lecture/project/goott2-final-project/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/Project/WEB-INF/lib/jstl-1.2.jar!/META-INF/c.tld", Long.valueOf(1153352682000L));
    _jspx_dependants.put("/WEB-INF/lib/jstl-1.2.jar", Long.valueOf(1696915893748L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    final java.lang.String _jspx_method = request.getMethod();
    if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSP들은 오직 GET, POST 또는 HEAD 메소드만을 허용합니다. Jasper는 OPTIONS 메소드 또한 허용합니다.");
      return;
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"zxx\">\r\n");
      out.write("  <head>\r\n");
      out.write("    <meta charset=\"UTF-8\" />\r\n");
      out.write("    <meta name=\"description\" content=\"Ogani Template\" />\r\n");
      out.write("    <meta name=\"keywords\" content=\"Ogani, unica, creative, html\" />\r\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n");
      out.write("    <meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\" />\r\n");
      out.write("    \r\n");
      out.write("    <title>Ogani | Template</title>\r\n");
      out.write("\r\n");
      out.write("    <!-- Google Font -->\r\n");
      out.write("    <link\r\n");
      out.write("      href=\"https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap\"\r\n");
      out.write("      rel=\"stylesheet\"\r\n");
      out.write("    />\r\n");
      out.write("\r\n");
      out.write("    <!-- Css Styles -->\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"../resources/css/bootstrap.min.css\" type=\"text/css\" />\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"../resources/css/font-awesome.min.css\" type=\"text/css\" />\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"../resources/css/elegant-icons.css\" type=\"text/css\" />\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"../resources/css/nice-select.css\" type=\"text/css\" />\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"../resources/css/jquery-ui.min.css\" type=\"text/css\" />\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"../resources/css/owl.carousel.min.css\" type=\"text/css\" />\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"../resources/css/slicknav.min.css\" type=\"text/css\" />\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"../resources/css/style.css\" type=\"text/css\" />\r\n");
      out.write("  </head>\r\n");
      out.write("\r\n");
      out.write("  <body>\r\n");
      out.write("    <!-- Page Preloder -->\r\n");
      out.write("    <div id=\"preloder\">\r\n");
      out.write("      <div class=\"loader\"></div>\r\n");
      out.write("    </div>\r\n");
      out.write("\r\n");
      out.write("    <!-- Humberger Begin -->\r\n");
      out.write("    <div class=\"humberger__menu__overlay\"></div>\r\n");
      out.write("    <div class=\"humberger__menu__wrapper\">\r\n");
      out.write("      <div class=\"humberger__menu__logo\">\r\n");
      out.write("        <p style=\"font-size: 30px\">\r\n");
      out.write("          <img src=\"img/logo1.png\" alt=\"\" />Kyobo Books\r\n");
      out.write("        </p>\r\n");
      out.write("      </div>\r\n");
      out.write("      <div class=\"humberger__menu__cart\">\r\n");
      out.write("        <ul>\r\n");
      out.write("          <li>\r\n");
      out.write("            <a href=\"#\"><i class=\"fa fa-heart\"></i> <span>1</span></a>\r\n");
      out.write("          </li>\r\n");
      out.write("          <li>\r\n");
      out.write("            <a href=\"#\"><i class=\"fa fa-shopping-bag\"></i> <span>3</span></a>\r\n");
      out.write("          </li>\r\n");
      out.write("        </ul>\r\n");
      out.write("      </div>\r\n");
      out.write("      <div class=\"humberger__menu__widget\">\r\n");
      out.write("        <div class=\"header__top__right__auth\">\r\n");
      out.write("          <a href=\"#\"><i class=\"fa fa-user\"></i>로그인</a>\r\n");
      out.write("        </div>\r\n");
      out.write("        <div class=\"header__top__right__auth\">\r\n");
      out.write("          <a href=\"#\"><i class=\"fa-solid fa-right-to-bracket\"></i>회원가입</a>\r\n");
      out.write("        </div>\r\n");
      out.write("      </div>\r\n");
      out.write("      <nav class=\"humberger__menu__nav mobile-menu\">\r\n");
      out.write("        <ul>\r\n");
      out.write("          <li>\r\n");
      out.write("            <a href=\"#\">베스트셀러</a>\r\n");
      out.write("            <ul class=\"header__menu__dropdown\">\r\n");
      out.write("              <li><a href=\"./shop-details.html\">주간</a></li>\r\n");
      out.write("              <li><a href=\"./shoping-cart.html\">월간</a></li>\r\n");
      out.write("              <li><a href=\"./checkout.html\">연간</a></li>\r\n");
      out.write("            </ul>\r\n");
      out.write("          </li>\r\n");
      out.write("          <li><a href=\"./shop-grid.html\">이벤트</a></li>\r\n");
      out.write("          <li>\r\n");
      out.write("            <a href=\"#\">신상품</a>\r\n");
      out.write("            <ul class=\"header__menu__dropdown\">\r\n");
      out.write("              <li><a href=\"./shop-details.html\">Shop Details</a></li>\r\n");
      out.write("              <li><a href=\"/shoppingCart/shoppingCart\">Shopping Cart</a></li>\r\n");
      out.write("              <li><a href=\"./checkout.html\">Check Out</a></li>\r\n");
      out.write("              <li><a href=\"./blog-details.html\">Blog Details</a></li>\r\n");
      out.write("            </ul>\r\n");
      out.write("          </li>\r\n");
      out.write("          <li><a href=\"./blog.html\">Blog</a></li>\r\n");
      out.write("          <li><a href=\"./contact.html\">고객센터</a></li>\r\n");
      out.write("        </ul>\r\n");
      out.write("      </nav>\r\n");
      out.write("      <div id=\"mobile-menu-wrap\"></div>\r\n");
      out.write("      <div class=\"header__top__right__social\">\r\n");
      out.write("        <a href=\"#\"><i class=\"fa fa-facebook\"></i></a>\r\n");
      out.write("        <a href=\"#\"><i class=\"fa fa-twitter\"></i></a>\r\n");
      out.write("        <a href=\"#\"><i class=\"fa fa-linkedin\"></i></a>\r\n");
      out.write("        <a href=\"#\"><i class=\"fa fa-pinterest-p\"></i></a>\r\n");
      out.write("      </div>\r\n");
      out.write("      <div class=\"humberger__menu__contact\">\r\n");
      out.write("      </div>\r\n");
      out.write("    </div>\r\n");
      out.write("    <!-- Humberger End -->\r\n");
      out.write("\r\n");
      out.write("    <!-- Header Section Begin -->\r\n");
      out.write("    <header class=\"header\">\r\n");
      out.write("      <div class=\"header__top\">\r\n");
      out.write("        <div class=\"container\">\r\n");
      out.write("          <div class=\"row\">\r\n");
      out.write("            <div class=\"col-lg-6 col-md-6\">\r\n");
      out.write("              <div class=\"header__top__left\"></div>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"col-lg-6 col-md-6\">\r\n");
      out.write("              <div class=\"header__top__right\">\r\n");
      out.write("                <div class=\"header__top__right__social\">\r\n");
      out.write("                  <a href=\"#\"><i class=\"fa fa-facebook\"></i></a>\r\n");
      out.write("                  <a href=\"#\"><i class=\"fa fa-twitter\"></i></a>\r\n");
      out.write("                  <a href=\"#\"><i class=\"fa fa-linkedin\"></i></a>\r\n");
      out.write("                  <a href=\"#\"><i class=\"fa fa-pinterest-p\"></i></a>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"header__top__right__auth\">\r\n");
      out.write("                  <a href=\"#\"><i class=\"fa fa-user\"></i> 로그인</a>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"header__top__right__auth\">\r\n");
      out.write("                  <a href=\"#\"\r\n");
      out.write("                    ><i class=\"fa-solid fa-right-to-bracket\"></i>회원가입</a\r\n");
      out.write("                  >\r\n");
      out.write("                </div>\r\n");
      out.write("              </div>\r\n");
      out.write("            </div>\r\n");
      out.write("          </div>\r\n");
      out.write("        </div>\r\n");
      out.write("      </div>\r\n");
      out.write("      <div class=\"container\">\r\n");
      out.write("        <div class=\"row\">\r\n");
      out.write("          <div class=\"col-lg-3\">\r\n");
      out.write("            <div class=\"header__logo\">\r\n");
      out.write("              <a href=\"./index.html\">Kyobo Books</a>\r\n");
      out.write("            </div>\r\n");
      out.write("          </div>\r\n");
      out.write("          <div class=\"col-lg-6\">\r\n");
      out.write("            <nav class=\"header__menu\">\r\n");
      out.write("              <ul>\r\n");
      out.write("                <li class=\"active\"><a href=\"./index.html\">베스트 셀러</a></li>\r\n");
      out.write("                <li><a href=\"./shop-grid.html\">이벤트</a></li>\r\n");
      out.write("                <li>\r\n");
      out.write("                  <a href=\"#\">신상품</a>\r\n");
      out.write("                  <ul class=\"header__menu__dropdown\">\r\n");
      out.write("                    <li><a href=\"./shop-details.html\">Shop Details</a></li>\r\n");
      out.write("                    <li><a href=\"/shoppingCart/shoppingCart\">Shopping Cart</a></li>\r\n");
      out.write("                    <li><a href=\"./checkout.html\">Check Out</a></li>\r\n");
      out.write("                    <li><a href=\"./blog-details.html\">Blog Details</a></li>\r\n");
      out.write("                  </ul>\r\n");
      out.write("                </li>\r\n");
      out.write("                <li><a href=\"./blog.html\">무슨이름?</a></li>\r\n");
      out.write("                <li><a href=\"./contact.html\">고객센터</a></li>\r\n");
      out.write("              </ul>\r\n");
      out.write("            </nav>\r\n");
      out.write("          </div>\r\n");
      out.write("          <div class=\"col-lg-3\">\r\n");
      out.write("            <div class=\"header__cart\">\r\n");
      out.write("              <ul>\r\n");
      out.write("                <li>\r\n");
      out.write("                  <a href=\"#\"><i class=\"fa fa-heart\"></i> <span>1</span></a>\r\n");
      out.write("                </li>\r\n");
      out.write("                <li>\r\n");
      out.write("                  <a href=\"#\"\r\n");
      out.write("                    ><i class=\"fa fa-shopping-bag\"></i> <span>3</span></a\r\n");
      out.write("                  >\r\n");
      out.write("                </li>\r\n");
      out.write("              </ul>\r\n");
      out.write("          </div>\r\n");
      out.write("        </div>\r\n");
      out.write("        <div class=\"humberger__open\">\r\n");
      out.write("          <i class=\"fa fa-bars\"></i>\r\n");
      out.write("        </div>\r\n");
      out.write("      </div>\r\n");
      out.write("      </div>\r\n");
      out.write("    </header>\r\n");
      out.write("    <!-- Header Section End -->\r\n");
      out.write("\r\n");
      out.write("    <!-- Hero Section Begin -->\r\n");
      out.write("    <section class=\"hero\">\r\n");
      out.write("      <div class=\"container\">\r\n");
      out.write("        <div class=\"row\">\r\n");
      out.write("          <div class=\"col-lg-3\">\r\n");
      out.write("            <div class=\"hero__categories\">\r\n");
      out.write("              <div class=\"hero__categories__all\">\r\n");
      out.write("                <i class=\"fa fa-bars\"></i>\r\n");
      out.write("                <span>Category</span>\r\n");
      out.write("              </div>\r\n");
      out.write("              <div id=\"drop_in\" style=\"display: flex; width: 250%\">\r\n");
      out.write("                <ul>\r\n");
      out.write("                  <li><a href=\"#\" onclick=\"kor()\">국내도서</a></li>\r\n");
      out.write("                  <li><a href=\"#\" onclick=\"eng()\">서양도서</a></li>\r\n");
      out.write("                  <li><a href=\"#\" onclick=\"jap()\">일본도서</a></li>\r\n");
      out.write("                </ul>\r\n");
      out.write("                <div id=\"drop_in_category\" style=\"display: flex\">\r\n");
      out.write("                  <ul>\r\n");
      out.write("                    <li>\r\n");
      out.write("                      <a href=\"#\" style=\"font-weight: bold\">국내도서 전체</a>\r\n");
      out.write("                    </li>\r\n");
      out.write("                    <li><a href=\"#\">소설</a></li>\r\n");
      out.write("                    <li><a href=\"#\">시/에세이</a></li>\r\n");
      out.write("                    <li><a href=\"#\">인문</a></li>\r\n");
      out.write("                    <li><a href=\"#\">가정/육아</a></li>\r\n");
      out.write("                    <li><a href=\"#\">요리</a></li>\r\n");
      out.write("                    <li><a href=\"#\">건강</a></li>\r\n");
      out.write("                    <li><a href=\"#\">취미/실용/스포츠</a></li>\r\n");
      out.write("                    <li><a href=\"#\">경제/경영</a></li>\r\n");
      out.write("                    <li><a href=\"#\">자기계발</a></li>\r\n");
      out.write("                    <li><a href=\"#\">정치/사회</a></li>\r\n");
      out.write("                    <li><a href=\"#\">역사/문화</a></li>\r\n");
      out.write("                  </ul>\r\n");
      out.write("                  <ul style=\"padding-top: 60px\">\r\n");
      out.write("                    <li><a href=\"#\">종교</a></li>\r\n");
      out.write("                    <li><a href=\"#\">예술/대중문화</a></li>\r\n");
      out.write("                    <li><a href=\"#\">중/고등참고서</a></li>\r\n");
      out.write("                    <li><a href=\"#\">기술/공학</a></li>\r\n");
      out.write("                    <li><a href=\"#\">외국어</a></li>\r\n");
      out.write("                    <li><a href=\"#\">과학</a></li>\r\n");
      out.write("                    <li><a href=\"#\">취섭/수험서</a></li>\r\n");
      out.write("                    <li><a href=\"#\">여행</a></li>\r\n");
      out.write("                    <li><a href=\"#\">컴퓨터/IT</a></li>\r\n");
      out.write("                    <li><a href=\"#\">잡지</a></li>\r\n");
      out.write("                    <li><a href=\"#\">청소년</a></li>\r\n");
      out.write("                  </ul>\r\n");
      out.write("                  <ul style=\"padding-top: 60px\">\r\n");
      out.write("                    <li><a href=\"#\">초등 참고서</a></li>\r\n");
      out.write("                    <li><a href=\"#\">유아(0~7세)</a></li>\r\n");
      out.write("                    <li><a href=\"#\">어린이(초등)</a></li>\r\n");
      out.write("                    <li><a href=\"#\">만화</a></li>\r\n");
      out.write("                    <li><a href=\"#\">대학교재</a></li>\r\n");
      out.write("                    <li><a href=\"#\">한국소개도서</a></li>\r\n");
      out.write("                    <li><a href=\"#\">교보 오리지널</a></li>\r\n");
      out.write("                  </ul>\r\n");
      out.write("                </div>\r\n");
      out.write("              </div>\r\n");
      out.write("            </div>\r\n");
      out.write("          </div>\r\n");
      out.write("          <div class=\"col-lg-9\">\r\n");
      out.write("            <div class=\"hero__search\">\r\n");
      out.write("              <div class=\"hero__search__form\">\r\n");
      out.write("                <form action=\"#\">\r\n");
      out.write("                  <div class=\"hero__search__categories\">\r\n");
      out.write("                    All Categories\r\n");
      out.write("                    <span class=\"arrow_carrot-down\"></span>\r\n");
      out.write("                  </div>\r\n");
      out.write("                  <input type=\"text\" placeholder=\"What do yo u need?\" />\r\n");
      out.write("                  <button type=\"submit\" class=\"site-btn\">SEARCH</button>\r\n");
      out.write("                </form>\r\n");
      out.write("              </div>\r\n");
      out.write("            </div>\r\n");
      out.write("          </div>\r\n");
      out.write("        </div>\r\n");
      out.write("      </div>\r\n");
      out.write("    </section>\r\n");
      out.write("    <!-- Hero Section End -->\r\n");
      out.write("\r\n");
      out.write("    <!-- Js Plugins -->\r\n");
      out.write("    <script\r\n");
      out.write("      src=\"https://kit.fontawesome.com/fd7fb2445c.js\"\r\n");
      out.write("      crossorigin=\"anonymous\"\r\n");
      out.write("    ></script>\r\n");
      out.write("    <script src=\"/resources/js/jquery-3.3.1.min.js\"></script>\r\n");
      out.write("    <script src=\"/resources/js/bootstrap.min.js\"></script>\r\n");
      out.write("    <script src=\"/resources/js/jquery.nice-select.min.js\"></script>\r\n");
      out.write("    <script src=\"/resources/js/jquery-ui.min.js\"></script>\r\n");
      out.write("    <script src=\"/resources/js/jquery.slicknav.js\"></script>\r\n");
      out.write("    <script src=\"/resources/js/mixitup.min.js\"></script>\r\n");
      out.write("    <script src=\"/resources/js/owl.carousel.min.js\"></script>\r\n");
      out.write("    <script src=\"/resources/js/main.js\"></script>\r\n");
      out.write("  </body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
