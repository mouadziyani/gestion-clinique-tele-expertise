package ma.youcode.clinic.feature.patient.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import ma.youcode.clinic.feature.patient.service.PatientService;

@WebServlet("/nurse/patient/add")
public class AddPatientServlet extends HttpServlet {
    private PatientService patientService;

    @Override
    public void init() throws ServletException {
        patientService = new PatientService();
    }
}
