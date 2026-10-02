package ma.youcode.clinic.feature.consultation.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import ma.youcode.clinic.feature.consultation.service.ConsultationService;
import ma.youcode.clinic.feature.patient.service.PatientService;
import ma.youcode.clinic.modal.Consultation;
import ma.youcode.clinic.modal.User;
import ma.youcode.clinic.modal.enums.StatutConsultation;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.UUID;

@WebServlet("/generalist/consultation/edit")
public class EditConsultationServlet extends HttpServlet {

    private final ConsultationService consultationService = new ConsultationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        String csrfToken = UUID.randomUUID().toString();
        req.getSession().setAttribute("csrfToken", csrfToken);
        req.setAttribute("csrfToken", csrfToken);

        Long consultationId = Long.parseLong(req.getParameter("id"));
        Consultation consultation = consultationService.findById(consultationId);

        req.setAttribute("consultation", consultation);
        req.setAttribute("statutsConsultation", StatutConsultation.values());

        req.getRequestDispatcher("/consultation/updateConsultation.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String tokenForm = req.getParameter("csrfToken");
        String tokenSession = (String) req.getSession().getAttribute("csrfToken");

        if (tokenForm == null || tokenSession == null || !tokenForm.equals(tokenSession)) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
            return;
        }

        req.getSession().removeAttribute("csrfToken");

        long consultationId;

        try {
            consultationId = Long.parseLong(req.getParameter("id"));
        } catch (NumberFormatException e) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid consultation id");
            return;
        }

        String observations = req.getParameter("observations");
        String diagnostic = req.getParameter("diagnostic");
        String treatment = req.getParameter("treatment");

        if (observations != null) observations = observations.trim();

        if (diagnostic != null) diagnostic = diagnostic.trim();

        if (treatment != null) treatment = treatment.trim();

        double cout;

        try {
            cout = Double.parseDouble(req.getParameter("cout"));
        } catch (NumberFormatException e) {
            Map<String, String> errors = new LinkedHashMap<>();
            errors.put("cout", "Le coût doit être un nombre valide.");

            req.getSession().setAttribute("errors", errors);

            res.sendRedirect(req.getContextPath() + "/generalist/consultations/edit?id=" + consultationId);
            return;
        }

        Map<String, String> errors = consultationService.update(consultationId, observations, diagnostic, treatment, cout, StatutConsultation.TERMINEE);

        if (!errors.isEmpty()) {
            req.getSession().setAttribute("errors", errors);

            res.sendRedirect(req.getContextPath() + "/generalist/consultations/edit?id=" + consultationId);
            return;
        }

        res.sendRedirect(req.getContextPath() + "/generalist/home");
    }
}