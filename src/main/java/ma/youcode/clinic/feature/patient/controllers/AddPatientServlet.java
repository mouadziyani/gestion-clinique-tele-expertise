package ma.youcode.clinic.feature.patient.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.youcode.clinic.feature.auth.service.UserService;
import ma.youcode.clinic.feature.consultation.service.ConsultationService;
import ma.youcode.clinic.feature.patient.service.PatientService;
import ma.youcode.clinic.modal.Consultation;
import ma.youcode.clinic.modal.User;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@WebServlet("/nurse/patient/add")
public class AddPatientServlet extends HttpServlet {
    private PatientService patientService;
    private UserService userService;

    @Override
    public void init() throws ServletException {
        patientService = new PatientService();
        userService = new UserService();
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


        String nom = req.getParameter("nom");
        String prenom = req.getParameter("prenom");
        String dateNaissance = req.getParameter("dateNaissance");
        String numeroSecuriteSociale = req.getParameter("numeroSecuriteSociale");
        String tensionArterielle = req.getParameter("tensionArterielle");
        String motif = req.getParameter("motif");
        String doctorIdParam = req.getParameter("doctorId");
        Double frequenceCardiaque = Double.parseDouble(req.getParameter("frequenceCardiaque").trim());
        Double temperature = Double.parseDouble(req.getParameter("temperature").trim());
        Double frequenceRespiratoire = Double.parseDouble(req.getParameter("frequenceRespiratoire").trim());


        if (nom != null) nom = nom.trim();
        if (prenom != null) prenom = prenom.trim();
        if (dateNaissance != null) dateNaissance = dateNaissance.trim();
        if (numeroSecuriteSociale != null) numeroSecuriteSociale = numeroSecuriteSociale.trim();
        if (tensionArterielle != null) tensionArterielle = tensionArterielle.trim();
        if (motif != null) motif = motif.trim();
        Long doctorId = null;

        if (doctorIdParam != null && !doctorIdParam.isBlank()) {
            try {
                doctorId = Long.parseLong(doctorIdParam);
            } catch (NumberFormatException e) {
                doctorId = null;
            }
        }

        Map<String, String> errors = patientService.createPatient(nom, prenom, dateNaissance, numeroSecuriteSociale, tensionArterielle, frequenceCardiaque, temperature, frequenceRespiratoire, motif, doctorId);

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("doctors", userService.getAllDoctors());

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
        req.setAttribute("doctors" , userService.getAllDoctors());
        req.getRequestDispatcher("/patient/addPatient.jsp").forward(req, resp);
    }
}
