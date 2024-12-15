import UIKit
import PDFKit
import FirebaseAuth
import FirebaseDatabase

class GeneratedCVViewController: UIViewController {

    // Data fetched from Firebase
    var aboutMe: String = ""
    var cvData: [String: Any] = [:]
    var skills: [String] = []
    var interests: [String] = []
    var workExperience: [String] = []

    @IBOutlet weak var cvTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCVData()
    }

    // Fetch CV data from Firebase
    private func fetchCVData() {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users").child(userUID)

        databaseRef.observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let self = self else { return }
            guard let data = snapshot.value as? [String: Any] else {
                self.displayNoData()
                return
            }

            // Extract CV details from Firebase
            self.aboutMe = data["aboutMe"] as? String ?? "N/A"
            self.cvData = data["cv"] as? [String: Any] ?? [:]
            self.skills = data["skills"] as? [String] ?? []
            self.interests = data["interests"] as? [String] ?? []
            self.workExperience = data["workExperience"] as? [String] ?? []

            // Update the CV text view
            DispatchQueue.main.async {
                let formattedCV = self.formatCVContent(
                    aboutMe: self.aboutMe,
                    cvData: self.cvData,
                    skills: self.skills,
                    interests: self.interests,
                    workExperience: self.workExperience
                )
                self.cvTextView.attributedText = formattedCV
                //self.cvTextView.backgroundColor = .black // Background color
                self.cvTextView.textColor = .white       // Text color
            }
        }
    }

    // Display fallback if no data is found
    private func displayNoData() {
        DispatchQueue.main.async {
            self.cvTextView.text = "No CV content available."
            self.cvTextView.textColor = .white
            //self.cvTextView.backgroundColor = .black
        }
    }

    // Format CV content
    private func formatCVContent(
        aboutMe: String,
        cvData: [String: Any],
        skills: [String],
        interests: [String],
        workExperience: [String]
    ) -> NSAttributedString {
        let email = cvData["email"] as? String ?? "N/A"
        let language = cvData["language"] as? String ?? "N/A"
        let education = cvData["education"] as? String ?? "N/A"
        let occupation = cvData["occupation"] as? String ?? "N/A"
        let phoneNumber = cvData["phoneNumber"] as? String ?? "N/A"

        let boldFont = UIFont.boldSystemFont(ofSize: 16)
        let regularFont = UIFont.systemFont(ofSize: 14)
        let textColor = UIColor.white
        let formattedCV = NSMutableAttributedString()

        // Title
        formattedCV.append(NSAttributedString(
            string: "---- CV ----\n\n",
            attributes: [.font: boldFont, .foregroundColor: textColor]
        ))

        // About Me Section
        formattedCV.append(NSAttributedString(
            string: "About Me:\n",
            attributes: [.font: boldFont, .foregroundColor: textColor]
        ))
        formattedCV.append(NSAttributedString(
            string: "\(aboutMe)\n\n",
            attributes: [.font: regularFont, .foregroundColor: textColor]
        ))

        // Skills Section
        formattedCV.append(NSAttributedString(
            string: "Skills:\n",
            attributes: [.font: boldFont, .foregroundColor: textColor]
        ))
        formattedCV.append(NSAttributedString(
            string: "\(skills.joined(separator: ", "))\n\n",
            attributes: [.font: regularFont, .foregroundColor: textColor]
        ))

        // Interests Section
        formattedCV.append(NSAttributedString(
            string: "Interests:\n",
            attributes: [.font: boldFont, .foregroundColor: textColor]
        ))
        formattedCV.append(NSAttributedString(
            string: "\(interests.joined(separator: ", "))\n\n",
            attributes: [.font: regularFont, .foregroundColor: textColor]
        ))

        // Language Section
        formattedCV.append(NSAttributedString(
            string: "Language:\n",
            attributes: [.font: boldFont, .foregroundColor: textColor]
        ))
        formattedCV.append(NSAttributedString(
            string: "\(language)\n\n",
            attributes: [.font: regularFont, .foregroundColor: textColor]
        ))

        // Education Section
        formattedCV.append(NSAttributedString(
            string: "Education:\n",
            attributes: [.font: boldFont, .foregroundColor: textColor]
        ))
        formattedCV.append(NSAttributedString(
            string: "\(education)\n\n",
            attributes: [.font: regularFont, .foregroundColor: textColor]
        ))

        // Occupation Section
        formattedCV.append(NSAttributedString(
            string: "Occupation:\n",
            attributes: [.font: boldFont, .foregroundColor: textColor]
        ))
        formattedCV.append(NSAttributedString(
            string: "\(occupation)\n\n",
            attributes: [.font: regularFont, .foregroundColor: textColor]
        ))

        // Contact Information
        formattedCV.append(NSAttributedString(
            string: "Contact Information:\n",
            attributes: [.font: boldFont, .foregroundColor: textColor]
        ))
        formattedCV.append(NSAttributedString(
            string: "Email: \(email)\nPhone: \(phoneNumber)\n\n",
            attributes: [.font: regularFont, .foregroundColor: textColor]
        ))

        // Work Experience Section
        formattedCV.append(NSAttributedString(
            string: "Work Experience:\n",
            attributes: [.font: boldFont, .foregroundColor: textColor]
        ))
        formattedCV.append(NSAttributedString(
            string: "\(workExperience.joined(separator: ", "))\n",
            attributes: [.font: regularFont, .foregroundColor: textColor]
        ))

        return formattedCV
    }

    // MARK: Save as PDF
    @IBAction func saveAsPDFTapped(_ sender: UIButton) {
        generatePDF(cvContent: cvTextView.text)
    }
    @IBAction func saveAsDocTapped(_ sender: UIButton) {
        saveAsDoc(cvContent: cvTextView.text)
    }
    
    // MARK: Save as PDF
    private func generatePDF(cvContent: String) {
        let pdfMetaData = [
            kCGPDFContextCreator: "BetterJobz App",
            kCGPDFContextAuthor: "Generated by BetterJobz"
        ]
        let pdfPageFrame = CGRect(x: 0, y: 0, width: 612, height: 792)
        let pdfData = NSMutableData()

        UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame, pdfMetaData)
        UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.blue
        ]
        cvContent.draw(
            in: CGRect(x: 20, y: 20, width: pdfPageFrame.width - 40, height: pdfPageFrame.height - 40),
            withAttributes: attributes
        )
        UIGraphicsEndPDFContext()

        let fileManager = FileManager.default
        let docsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let pdfURL = docsURL.appendingPathComponent("GeneratedCV.pdf")

        do {
            try pdfData.write(to: pdfURL)
            showAlert(title: "Success", message: "PDF saved successfully at \(pdfURL.path)")
        } catch {
            showAlert(title: "Error", message: "Failed to save PDF: \(error.localizedDescription)")
        }
    }

    // MARK: Save as DOC (Plain Text File)
    private func saveAsDoc(cvContent: String) {
        let fileManager = FileManager.default
        let docsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let docURL = docsURL.appendingPathComponent("GeneratedCV.doc")

        do {
            try cvContent.write(to: docURL, atomically: true, encoding: .utf8)
            showAlert(title: "Success", message: "DOC file saved successfully at \(docURL.path)")
        } catch {
            showAlert(title: "Error", message: "Failed to save DOC file: \(error.localizedDescription)")
        }
    }

    // Helper Method to Show Alerts
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

