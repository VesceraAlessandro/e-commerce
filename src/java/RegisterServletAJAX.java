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
@WebServlet(urlPatterns = {"/RegisterServletAJAX"})
public class RegisterServletAJAX extends HttpServlet {

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
        
        String name = request.getParameter("name");
        String lastname = request.getParameter("lastname");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        //controlla le condizioni
        if(request.getSession().getAttribute("username") != null) return;//già dentro
        if(!email.matches("^[(a-zA-Z-0-9-\\_\\+\\.)]+@[(a-zA-Z-0-9-\\_\\+\\.)]+\\.[(a-zA-Z-0-9)]{2,3}$")) return;//email invalida
        if(password.length() < 8 || password.length() > 30) return;//password invalida
        //loading drivers for mysql
        Class.forName("com.mysql.jdbc.Driver");
        //creating connection with the database 
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");
        PreparedStatement ps = con.prepareStatement("insert into utenti(nome, cognome, username, email, password) values(?, ?, ?, ?, ?)");
        ps.setString(1, name);
        ps.setString(2, lastname);
        ps.setString(3, username);
        ps.setString(4, email);
        ps.setString(5, password);
        //XML response
        out.print("<response>");
        try{
            ps.executeUpdate();
        }catch(SQLException ex){
            do{
                if(ex.getMessage().startsWith("Duplicate entry '") && ex.getMessage().endsWith("' for key 'username'")){
                    out.print("<error><field>username</field><message>Questo nome utente è già in uso</message></error>");
                }else if(ex.getMessage().startsWith("Duplicate entry '") && ex.getMessage().endsWith("' for key 'email'")){
                    out.print("<error><field>email</field><message>Questa email è già associata ad un utente</message></error>");
                }
                ex= ex.getNextException();
            }while(ex != null);
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
