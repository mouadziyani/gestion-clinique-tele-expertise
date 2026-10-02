package ma.youcode.clinic.feature.patient.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.youcode.clinic.feature.consultation.service.ConsultationService;
import ma.youcode.clinic.feature.patient.service.PatientService;
import ma.youcode.clinic.modal.Consultation;

import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@WebServlet("/nurse/patient/add")
public class AddPatientServlet extends HttpServlet {
    private PatientService patientService;

    @Override
    public void init() throws ServletException {
        patientService = new PatientService();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String tokenForm = req.getParameter("csrfToken");
        String tokenSession = (String) req.getSession().getAttribute("csrfToken");

        if (tokenForm == null || tokenSession == null || !tokenForm.equals(tokenSession)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
            return;
        }

        req.getSession().removeAttribute("csrfToken");

        String nom = req.getParameter("nom").trim();
        String prenom = req.getParameter("prenom").trim();
        String dateNaissance = req.getParameter("dateNaissance").trim();
        String numeroSecuriteSociale = req.getParameter("numeroSecuriteSociale").trim();
        String tensionArterielle = req.getParameter("tensionArterielle").trim();
        Double frequenceCardiaque = Double.parseDouble(req.getParameter("frequenceCardiaque").trim());
        Double temperature = Double.parseDouble(req.getParameter("temperature"));
        Double frequenceRespiratoire = Double.parseDouble(req.getParameter("frequenceRespiratoire").trim());

        Map<String , String> errors = patientService.createPatient(nom , prenom , dateNaissance , numeroSecuriteSociale , tensionArterielle , frequenceCardiaque , temperature , frequenceRespiratoire);

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/patient/addPatient.jsp").forward(req, resp);
            return;
        }

        req.getSession().setAttribute("success", "Patient créé avec succès.");
        resp.sendRedirect(req.getContextPath() + "/nurse/home");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String csrfToken = UUID.randomUUID().toString();
        req.getSession().setAttribute("csrfToken", csrfToken);
        req.setAttribute("csrfToken" , csrfToken);
        req.getRequestDispatcher("/patient/addPatient.jsp").forward(req, resp);
    }
}
