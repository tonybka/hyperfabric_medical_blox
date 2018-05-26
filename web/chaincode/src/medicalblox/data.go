package main

import "time"

// HealthProfile - health profile from patient
type HealthProfile struct {
	PatientPersonalInfo PatientPersonalInfo `json:"patient_personal_info"`
	HeartHealth         HeartHealth         `json:"heart_health"`
	CreatedDate         time.Time           `json:"created_date"`
	LastUpdateDate      time.Time           `json:"last_update_date"`
}

// PatientPersonalInfo - personal information of patient
type PatientPersonalInfo struct {
	FirstName  string `json:"first_name"`
	LastName   string `json:"last_name"`
	BirthDate  int16  `json:"birth_date"`
	BirthMonth int16  `json:"birth_month"`
	BirthYear  int16  `json:"birth_year"`
	Street     string `json:"street"`
	City       string `json:"city"`
	State      string `json:"state"`
	Country    string `json:"country"`
}

// HeartHealth - heart health profile
type HeartHealth struct {
	HeartHealthLipid       HeartHealthLipid       `json:"heart_health_lipid"`
	HeartHealthRatio       HeartHealthRatio       `json:"heart_health_ratio"`
	HeartHealthRiskFactor  HeartHealthRiskFactor  `json:"heart_health_riskfactor"`
	HeartHealthLipoProtein HeartHealthLipoProtein `json:"heart_health_lipoprotein"`
	Description            string                 `json:"desc"`
}

// HeartHealthLipid - heart health in Lipid profile
type HeartHealthLipid struct {
	TotalCholesterol float64 `json:"total_cholesterol"`
	HDLC             float64 `json:"hdl_c"`
	LDLC             float64 `json:"ldl_c"`
	OxidizedLDL      float64 `json:"oxidized_ldl"`
	Triglycerides    float64 `json:"triglycerides"`
}

// HeartHealthRatio - heart health in Ratio profile
type HeartHealthRatio struct {
	TotalCholesterolDivHDLC float64 `json:"totalcholesterol_hdlc"`
	LDLCdivHDLC             float64 `json:"ldlc_hdlc"`
	OxidizedLDLdivHDLC      float64 `json:"oxidizedldl_hdlc"`
	SmalldenseLDLCdivLDLC   float64 `json:"smalldenseldlc_ldlc"`
	ApoBdivApoA1            float64 `json:"apob_apoa1"`
}

// HeartHealthRiskFactor - heart health risk factors
type HeartHealthRiskFactor struct {
	Homocysteine  float64 `json:"homocysteine"`
	CRP           float64 `json:"crp"`
	BloodPressure string  `json:"blood_pressure"`
}

// HeartHealthLipoProtein - heart health lipo protein
type HeartHealthLipoProtein struct {
	ApoA1 float64 `json:"apo_a1"`
	ApoB  float64 `json:"apo_b"`
}
