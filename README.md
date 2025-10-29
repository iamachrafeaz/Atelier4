# Projet JEE - Application Distribuée EJB3 "Getudiants"

Ce projet est une application web Java EE de gestion de scolarité (Étudiants, Modules, Notes). Il met en œuvre une architecture distribuée basée sur **EJB3 (Enterprise JavaBeans)** pour la logique métier et **JPA** pour la persistance des données. L'interface utilisateur est construite selon le modèle **MVC 2** en utilisant des **Servlets** (Contrôleur) et des **JSP** (Vue).

## 🚀 Technologies Utilisées

  * **Serveur d'application :** WildFly
  * **Logique Métier :** EJB 3.x (Stateless Session Bean)
  * **Persistance :** JPA 3.x / Hibernate
  * **Base de Données :** MySQL 8
  * **Frontend (MVC) :** Servlets 6.0, JSP 3.1
  * **Build :** Maven
  * **API :** Jakarta EE 10

## 📋 Prérequis

Avant de commencer, assurez-vous d'avoir installé les outils suivants :

  * JDK 17 ou supérieur
  * Maven 3.6 ou supérieur
  * Un serveur MySQL (accessible sur `localhost:3306`)
  * Le serveur d'application WildFly

## 🛠️ Guide d'Installation et de Configuration

Pour faire fonctionner ce projet, suivez ces étapes dans l'ordre.

### Étape 1 : Base de Données (MySQL)

1.  Connectez-vous à votre SGBD MySQL.
2.  Exécutez le script SQL suivant pour créer la base de données `Getudiants` et ses tables.

<!-- end list -->

```sql
CREATE DATABASE IF NOT EXISTS Getudiants;
USE Getudiants;

CREATE TABLE Etudiant (
    id_etudiant INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    cne VARCHAR(20) UNIQUE NOT NULL,
    adresse VARCHAR(255),
    niveau VARCHAR(50)
);

CREATE TABLE Module (
    id_module INT PRIMARY KEY AUTO_INCREMENT,
    nom_module VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Suivie (
    id_suivie INT PRIMARY KEY AUTO_INCREMENT,
    id_etudiant INT NOT NULL,
    id_module INT NOT NULL,
    note DECIMAL(4, 2),
    date_evaluation DATE,
    FOREIGN KEY (id_etudiant) REFERENCES Etudiant(id_etudiant) ON DELETE CASCADE,
    FOREIGN KEY (id_module) REFERENCES Module(id_module) ON DELETE CASCADE,
    UNIQUE KEY unique_suivie (id_etudiant, id_module)
);
```

### Étape 2 : Configuration du Serveur (WildFly)

C'est l'étape la plus critique. L'application a besoin d'une source de données (Datasource) JTA pour se connecter à MySQL.

1.  **Ajouter le Driver MySQL :** Vous devez d'abord installer le "MySQL Connector/J" (le fichier `.jar`) dans WildFly. La méthode la plus simple est de le copier dans `WILDFLY_HOME/standalone/deployments/`.
2.  **Créer le Datasource JTA :**
      * Démarrez WildFly (`standalone.sh` ou `standalone.bat`).
      * Accédez à la console d'administration : `http://localhost:9990`.
      * Allez dans `Configuration` $\rightarrow$ `Subsystems` $\rightarrow$ `Datasources & Drivers` $\rightarrow$ `Datasources`.
      * Cliquez sur `Add` et créez un **Datasource non-XA**.
      * **Nom (Name) :** `MySqlDS` (ou un nom de votre choix)
      * **JNDI Name :** `java:/mysql` (Ceci est **crucial** et doit correspondre au `persistence.xml`)
      * Sélectionnez le driver MySQL que vous venez d'ajouter.
      * **Connection URL :** `jdbc:mysql://localhost:3306/Getudiants`
      * Entrez votre **Username** et **Password** MySQL.
      * Testez la connexion (`Test Connection`) avant de sauvegarder.

### Étape 3 : Configuration du Projet (persistence.xml)

Assurez-vous que le fichier `persistence.xml` de votre module EJB (situé dans `src/main/resources/META-INF/`) est configuré pour utiliser le Datasource WildFly.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<persistence version="3.1"
    xmlns="jakarta.ee/xml/ns/persistence"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="jakarta.ee/xml/ns/persistence https://jakarta.ee/xml/ns/persistence/persistence_3_1.xsd">
    
    <persistence-unit name="cnx" transaction-type="JTA">
        <jta-data-source>java:/mysql</jta-data-source> // Changer cette partie
        
        <properties>
            <property name="hibernate.hbm2ddl.auto" value="update"/> 
            <property name="jakarta.persistence.schema-generation.database.action" value="none"/>
        </properties>
    </persistence-unit>
</persistence>
```

## 📦 Compilation (Build)

Le projet est divisé en deux modules Maven :

1.  **Module EJB** : Contient les entités JPA et le Session Bean.
2.  **Module Web** : Contient les Servlets et les JSP.

Pour compiler l'ensemble du projet, ouvrez un terminal à la racine (ou dans chaque module) et exécutez :

```bash
mvn clean install
```

Cela générera deux fichiers dans les dossiers `target/` respectifs :

  * Un fichier `.jar` (ex: `ejbProject-1.0-SNAPSHOT.jar`)
  * Un fichier `.war` (ex: `ejbWeb-1.0-SNAPSHOT.war`)

## 🚀 Déploiement

1.  Assurez-vous que votre serveur WildFly est démarré.
2.  Copiez **les deux** fichiers (`.jar` et `.war`) dans le dossier de déploiement de WildFly :
    `WILDFLY_HOME/standalone/deployments/`
3.  Surveillez la console WildFly. Le serveur va "hot-deploy" les deux artefacts. Vous devriez voir des messages indiquant que le `.jar` (EJB) et le `.war` (Web) sont déployés.

## 💻 Utilisation de l'Application

Une fois l'application déployée, vous pouvez y accéder via votre navigateur. (En supposant que le `Context Path` de votre projet web est `ejbWeb-1.0-SNAPSHOT`, comme vu dans vos logs).

  * **Page d'Accueil (Navigation) :**
    `http://localhost:8080/ejbWeb-1.0-SNAPSHOT/`

  * **Gestion des Étudiants :**
    `http://localhost:8080/ejbWeb-1.0-SNAPSHOT/etudiant?action=list`

  * **Gestion des Modules :**
    `http://localhost:8080/ejbWeb-1.0-SNAPSHOT/module?action=list`

  * **Gestion des Notes (Suivies) :**
    `http://localhost:8080/ejbWeb-1.0-SNAPSHOT/suivie?action=list`

-----

## 🏗️ Structure du Projet

### Module EJB (`getudiants-ejb`)

  * **Entités (Model)** : `com.fstt.entities`
      * `Etudiant.java`
      * `Module.java`
      * `Suivie.java`
  * **Logique Métier (EJB)** : `com.fstt.services`
      * `GestionScolariteRemote.java` (Interface Remote)
      * `GestionScolariteEJB.java` (Implémentation Stateless Bean)

### Module Web (`ejbWeb`)

  * **Contrôleurs (Servlets)** : `ma.fstt.ejbweb.controllers`
      * `EtudiantController.java` (URL: `/etudiant`)
      * `ModuleController.java` (URL: `/module`)
      * `SuivieController.java` (URL: `/suivie`)
  * **Vues (JSP)** : `src/main/webapp/`
      * `etudiant-list.jsp`
      * `etudiant-form.jsp`
      * `module-list.jsp`
      * `module-form.jsp`
      * `suivie-list.jsp`
      * `suivie-form.jsp`
