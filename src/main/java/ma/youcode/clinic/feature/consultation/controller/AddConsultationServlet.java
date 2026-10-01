package ma.youcode.clinic.feature.consultation.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import ma.youcode.clinic.feature.consultation.service.ConsultationService;
import ma.youcode.clinic.feature.patient.service.PatientService;
import ma.youcode.clinic.modal.Patient;
import ma.youcode.clinic.modal.User;
import ma.youcode.clinic.modal.enums.StatutConsultation;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@WebServlet("/generalist/consultations/add")
public class AddConsultationServlet extends HttpServlet {

    private final PatientService patientService = new PatientService();
    private final ConsultationService consultationService = new ConsultationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
            
        List<Patient> patients = patientService.findPatientsDuJour(LocalDate.now());
        req.setAttribute("patients", patients);
        req.getRequestDispatcher("/consultation/addConsultation.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        long patientId = Long.parseLong(req.getParameter("patientId"));
        User doctor = (User)req.getSession().getAttribute("user");
        long doctorId = doctor.getId();

        String motif = req.getParameter("motif").trim();
        String observations = req.getParameter("observations").trim();
        String diagnostic = req.getParameter("diagnostic").trim();
        String treatment = req.getParameter("treatment").trim();

        double cout = Double.parseDouble(req.getParameter("cout"));

        StatutConsultation statut = StatutConsultation.valueOf(req.getParameter("statut"));

        LocalDateTime dateConsultation = LocalDateTime.parse(req.getParameter("dateConsultation"));

        Map<String , String> errors = consultationService.create(
                patientId,
                doctorId,
                motif,
                observations,
                diagnostic,
                treatment,
                cout,
                statut,
                dateConsultation
        );

        if (!errors.isEmpty()) {
            req.getSession().setAttribute("errors" , errors);
            res.sendRedirect(req.getContextPath() + "/generalist/consultations/add");
            return;
        }

        res.sendRedirect(req.getContextPath() + "/generalist/home");
    }

}