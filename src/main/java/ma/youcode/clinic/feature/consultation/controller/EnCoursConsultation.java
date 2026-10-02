package ma.youcode.clinic.feature.consultation.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.youcode.clinic.feature.consultation.service.ConsultationService;
import ma.youcode.clinic.modal.Consultation;

import java.io.IOException;
import java.util.List;

@WebServlet("/generalist/consultations/en_cours")
public class EnCoursConsultation extends HttpServlet {
    private ConsultationService consultationService;

    @Override
    public void init() throws ServletException {
        consultationService = new ConsultationService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Consultation> consultations = consultationService.getEnCourConsultation();

        req.setAttribute("enCourConsultations" , consultations);
        req.getRequestDispatcher("/consultation/enCourConsultation.jsp").forward(req , resp);
    }
}
