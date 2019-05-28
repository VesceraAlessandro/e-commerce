package servlets;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Stefano
 */
@WebServlet(urlPatterns = {"/LoginServletAJAX"})
public class LoginServletAJAX extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String realPassword= null;
        boolean exist= false;
        //controlla le condizioni
        if(request.getSession().getAttribute("username") != null) return;//già dentro
        //loading drivers for mysql
        Class.forName("com.mysql.jdbc.Driver");
        //creating connection with the database 
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");
        PreparedStatement ps = con.prepareStatement("select * from utenti where username=? or email=?");
        ps.setString(1, username);
        ps.setString(2, username);
        ResultSet rs = ps.executeQuery();
        exist= rs.next();
        if(exist){
            realPassword= rs.getString("password");
        }
        
        //XML response
        out.print("<response>");
        if(!exist){
            out.println("<error><field>username</field><message>Impossibile trovare l'account</message></error>");
        }else if(!realPassword.equals(password)){
            out.println("<error><field>password</field><message>Password errata</message></error>");
        }else{
            out.print("<login/>");
            int id, number, creditNumber; String name, lastname, email, address;
            id= rs.getInt("id");
            name= rs.getString("nome");
            lastname= rs.getString("cognome");
            username= rs.getString("username");
            email= rs.getString("email");
            address= rs.getString("indirizzo");
            number= rs.getInt("numeroTelefono");
            creditNumber= rs.getInt("numeroCartaDiCredito");
            request.getSession().setAttribute("user", new User(id, number, creditNumber, name, lastname, username, email, password, address));
        }
        out.print("</response>");
            
        con.close();
        } catch (Exception ex) {
            //
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
