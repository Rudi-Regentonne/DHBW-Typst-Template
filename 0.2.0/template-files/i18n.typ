#let strings(lang) = {
  let de = (
    date-format: "[day].[month].[year]",
    processing-period: "Bearbeitungszeitraum",
    student-id: "Matrikelnummer",
    course: "Kurs",
    company-name: "Ausbildungsfirma",
    company-supervisor: "Betreuer der Ausbildungsfirma",
    university-supervisor: "Gutachter der Studienakademie",
    for-the-module: [für das Modul],
    in-degree-program: [des Studienganges],
    at-university: [an der],
    by: [von],
    submission-date: "Abgabedatum",
    default-university: [Dualen Hochschule Baden-Württemberg Karlsruhe],
    declaration-title: [Ehrenwörtliche Erklärung],
    declaration-body: [Ich versichere hiermit, dass ich die vorliegende Arbeit selbstständig verfasst und keine anderen
      als die angegebenen Quellen und Hilfsmittel verwendet habe und diese Arbeit bei keiner
      anderen Prüfung mit gleichem oder vergleichbarem Inhalt vorgelegt habe und diese bislang
      nicht veröffentlicht wurde. Des Weiteren versichere ich, dass die eingereichte elektronische
      Fassung mit der gedruckten Ausfertigung übereinstimmt.],
    signed: "gez.",
    place: "Ort",
    date: "Datum",
    signature: "Unterschrift",
    confidential-title: [Sperrvermerk],
    confidential-body: [Der Inhalt dieser Arbeit darf weder als Ganzes noch in Auszügen Personen
      außerhalb des Prüfungsprozesses und des Evaluationsverfahrens zugänglich gemacht
      werden, sofern keine anderslautende Genehmigung vom Dualen Partner vorliegt.],
    chapter: "Kapitel",
    list-of-figures: [Abbildungsverzeichnis],
    list-of-acronyms: [Abkürzungsverzeichnis],
    list-of-tables: [Tabellenverzeichnis],
    list-of-listings: [Quellcodeverzeichnis],
    list-of-equations: [Formelverzeichnis],
    bibliography-title: [Literaturverzeichnis],
    listing-supplement: [Quellcode],
  )
  let en = (
    date-format: "[month]/[day]/[year]",
    processing-period: "Processing Period",
    student-id: "Student ID",
    course: "Course",
    company-name: "Training Company",
    company-supervisor: "Company Supervisor",
    university-supervisor: "University Supervisor",
    for-the-module: [for the module],
    in-degree-program: [in the degree program],
    at-university: [at the],
    by: [by],
    submission-date: "Submission date",
    default-university: [Duale Hochschule Baden-Württemberg Karlsruhe],
    declaration-title: [Declaration of Authorship],
    declaration-body: [I hereby declare that I have authored this work independently and have not used
      any sources or aids other than those stated. I further declare that this work has not been
      submitted, in the same or comparable form, for any other examination, and has not previously
      been published. I also confirm that the submitted electronic version is identical to the
      printed copy.],
    signed: "signed",
    place: "Place",
    date: "Date",
    signature: "Signature",
    confidential-title: [Confidentiality Notice],
    confidential-body: [The contents of this work, neither in whole nor in part, may be made accessible
      to anyone outside the examination and evaluation process, unless the partner company grants
      explicit permission otherwise.],
    chapter: "Chapter",
    list-of-figures: [List of Figures],
    list-of-acronyms: [List of Abbreviations],
    list-of-tables: [List of Tables],
    list-of-listings: [List of Listings],
    list-of-equations: [List of Equations],
    bibliography-title: [Bibliography],
    listing-supplement: [Listing],
  )
  if lang == "en" { en } else { de }
}
