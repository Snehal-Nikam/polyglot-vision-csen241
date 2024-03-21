
<a name="readme-top"></a>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/Snehal-Nikam/polyglot-vision-csen241">
    <img src="frontend/src/assets/Polyglot.jpg" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">Polyglot Vision</h3>

  <p align="center">
    Welcome to the Polyglot Vision.
    <br />
    <!--<a href="https://github.com/Snehal-Nikam/polyglot-vision-csen241/blob/main/documents/Proposal.pdf"><strong>Project Praposal »</strong></a>-->
    <br />
    <br />
    <!--<a href="https://twittersentimentpredictor.streamlit.app/">View Demo</a>-->
    ·
    <a href="https://github.com/Snehal-Nikam/polyglot-vision-csen241/issues">Report Bug</a>
    ·
    <a href="https://github.com/Snehal-Nikam/polyglot-vision-csen241/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#Maintainers">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project
<!--
[![Product Name Screen Shot][product-screenshot]](images/homebanner.png)-->
<p align="justify">
The Polyglot Vision project is dedicated to solving
the problem of language barriers in videos. We’re using advanced
technology like cloud computing and artificial intelligence to
make translating subtitles easier. Specifically, we’re focusing on
translating subtitles from English to Spanish. To build our system,
we rely on Amazon Web Services (AWS), a powerful platform
that provides us with the tools and infrastructure we need. We’ve
put together a mix of different AWS services like Lambda functions,
EC2 instances, and Terraform to create a system that can
handle real-time subtitle translation efficiently. Behind the scenes,
we’ve developed a sophisticated backend using Flask, a web
framework for Python, to handle all the processing involved in
translating subtitles. This backend is seamlessly integrated with
AWS, ensuring smooth communication between different parts
of the system. On the user-facing side, we’ve designed a userfriendly
website using Vue.js, a popular JavaScript framework,
to provide an intuitive and enjoyable experience for viewers.
</p>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With


* [![Vuejs][Vuejs.org]][Vuejs-url]
* [![AWS][AWS.com]][Aws-url]
* [![Python3][Python3.com]][Python3-url]
* [![Terraform][Terraform.com]][Terraform-url]]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

### Installation : 
#### <u> Creating AWS Infrastructure : </u>
Follow  for installing aws-cli and terraform for building the aws infrastructure. 
Run the below command to create the infra : 
```
cd "path/to/terraform/folder"
```
```
terraform init
```
```
terraform validate
```
```
terraform apply
```
<i> <u>Note </u> : Please verify if all the <a href="https://github.com/Snehal-Nikam/polyglot-vision-csen241/blob/main/lambda/ReadMe.md">triggers for lambda</a> are created properly from terraform. <br>
To destroy the infra simply run : terraform destroy
</i><br>

<br>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->
## Usage : 
## FrontEnd Screenshots : 
![loginPage.png](documents%2FloginPage.png)

![uploadVideoPage.png](documents%2FuploadVideoPage.png)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Maintainers

* [Sourabh Deshmukh](https://github.com/sourabhdeshmukh)
* [Snehal Nikam](https://github.com/Snehal-Nikam)
* [Shreeja Malladi](https://github.com/SreejaMalladi)
* [Silvi Monga](https://github.com/SilviMonga)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->


[contributors-shield]: https://img.shields.io/github/contributors/Snehal-Nikam/ecommerce.svg?style=for-the-badge

[contributors-url]: https://github.com/Snehal-Nikam/ecommerce/graphs/contributors

[forks-shield]: https://img.shields.io/github/forks/Snehal-Nikam/ecommerce.svg?style=for-the-badge

[forks-url]: https://github.com/Snehal-Nikam/ecommerce/network/members

[stars-shield]: https://img.shields.io/github/stars/Snehal-Nikam/ecommerce.svg?style=for-the-badge

[stars-url]: https://github.com/Snehal-Nikam/ecommerce/stargazers

[issues-shield]: https://img.shields.io/github/issues/Snehal-Nikam/ecommerce.svg?style=for-the-badge

[issues-url]: https://github.com/Snehal-Nikam/ecommerce/issues

[license-shield]: https://img.shields.io/github/license/Snehal-Nikam/ecommerce.svg?style=for-the-badge

[license-url]: https://github.com/Snehal-Nikam/ecommerce/blob/master/LICENSE.txt

[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555

[linkedin-url]: https://www.linkedin.com/in/snehalnikam

[Vuejs.org]: https://img.shields.io/badge/Vuejs-v3.3-blue.svg?logo=vue.js
[Vuejs-url]: https://vuejs.org/

[AWS.com]:  https://img.shields.io/badge/AWS-Cloud-orange.svg?logo=amazon-aws
[AWS-url]: https://aws.amazon.com/

[Python3.com]: https://img.shields.io/badge/Python-3.9-green.svg?logo=python
[Python3-url]: https://www.python.org/

[Terraform.com]: https://img.shields.io/badge/Terraform-v0.15-lightgrey.svg?logo=terraform
[Terraform-url]: https://www.terraform.io/