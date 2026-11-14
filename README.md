# Gestion Clinique — Télé-Expertise (Jakarta EE)

![Java 17](https://img.shields.io/badge/Java%2017-ED8B00?style=flat-square&logo=openjdk&logoColor=white) ![Maven](https://img.shields.io/badge/Maven-C71A36?style=flat-square&logo=apachemaven&logoColor=white) ![Jakarta Servlet](https://img.shields.io/badge/Jakarta%20Servlet-F80000?style=flat-square) ![JSP / JSTL](https://img.shields.io/badge/JSP%20%2F%20JSTL-007396?style=flat-square) ![JDBC](https://img.shields.io/badge/JDBC-4479A1?style=flat-square) ![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat-square&logo=mysql&logoColor=white)

Application web **Java / Jakarta EE** de gestion clinique : accueil des patients par l'**infirmier(ère)**, saisie des **signes vitaux**, puis prise en charge par le **médecin généraliste** (consultations). Le projet commence avec **JDBC** (pattern DAO) et prépare la migration vers **JPA/Hibernate**, poursuivie dans l'API [teleexpertise](https://github.com/mouadziyani/teleexpertise).

## ✨ Fonctionnalités

- 🔐 Connexion / déconnexion avec mots de passe hachés (**jBCrypt**).
- 🛡️ Filtres d'**authentification** et de **rôles** (`AuthFilter`, `RoleFilter`).
- 🧑‍⚕️ **Infirmier** : enregistrement d'un patient et de ses signes vitaux, liste des patients du jour.
- 🩺 **Généraliste** : consultations en cours, modification et clôture d'une consultation.
- 🗃️ Pattern **DAO** (`JdbcUserDao`, `JdbcPatientDAO`, `JdbcConsultationDao`) et couche **Service**.
- ⚙️ Initialisation automatique de la base (`DatabaseInitializer`).

## 🗂️ Structure

```text
src/main/java/ma/youcode/clinic
├── config      # DataSource, initialisation BDD, listener
├── dao         # interface générique Dao
├── feature     # auth, patient, consultation (controllers, dao, service)
├── filters     # AuthFilter, RoleFilter
└── modal       # User, Patient, Consultation + enums
src/main/webapp # pages JSP (auth, nurse, generalist, patient, consultation)
```

## ▶️ Lancer le projet

```bash
mvn clean package
# déployer le .war sur Tomcat 10+ (configurer la datasource dans META-INF/context.xml)
```

---

## 👥 Auteurs

Projet réalisé en binôme par :

- **Mouad Ziyani** — [@mouadziyani](https://github.com/mouadziyani)
- **Wassim Rifi** — [@wassim-rifi-dev](https://github.com/wassim-rifi-dev)

[![Portfolio](https://img.shields.io/badge/Portfolio-mouadziyani.com-d92632?style=flat-square)](https://mouadziyani.com)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Mouad%20Ziyani-0A66C2?style=flat-square&logo=linkedin)](https://www.linkedin.com/in/mouad-ziyani-956484339)
[![GitHub](https://img.shields.io/badge/GitHub-mouadziyani-181717?style=flat-square&logo=github)](https://github.com/mouadziyani)

## 📄 Licence

© 2025-2026 Mouad Ziyani & Wassim Rifi — **Tous droits réservés.**

Ce projet est publié uniquement à titre de démonstration (portfolio). Il est **interdit** de copier, cloner, modifier, redistribuer ou réutiliser ce code, en tout ou en partie, sans l'autorisation écrite préalable des auteurs. Voir le fichier [LICENSE](LICENSE).
