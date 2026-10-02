package ma.youcode.clinic.feature.patient.controllers;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.youcode.clinic.feature.patient.service.PatientService;
import ma.youcode.clinic.modal.Patient;

@WebServlet("/nurse/patients/today")
public class TodayPatientsServlet extends HttpServlet {

    private PatientService patientService;

    @Override
    public void init() throws ServletException {
        patientService = new PatientService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        List<Patient> patients = patientService.findPatientsDuJour(LocalDate.now());

        req.setAttribute("todayPatients", patients);

        req.getRequestDispatcher("/patient/todayPatients.jsp").forward(req, resp);   
    }
}
