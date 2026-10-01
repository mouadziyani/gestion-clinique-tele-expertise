package ma.youcode.clinic.feature.consultation.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import ma.youcode.clinic.feature.consultation.service.ConsultationService;
import ma.youcode.clinic.feature.patient.service.PatientService;
import ma.youcode.clinic.modal.Patient;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/generalist/consultations/add")
public class ConsultationServlet extends HttpServlet {

    private final PatientService patientService = new PatientService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
            
        List<Patient> patients = patientService.findPatientsDuJour(LocalDate.now());
        req.setAttribute("patients", patients);
        req.getRequestDispatcher("/consultation/addConsultation.jsp").forward(req, res);
    }

}