import { Controller } from "stimulus"
import axios from 'axios'

export default class extends Controller {
  static targets = [ "followButton", "bookmark" ]

	bookmark(event) {
		event.preventDefault()
		let link = event.currentTarget
		let slug = link.dataset.slug
		let icon = this.bookmarkTarget

		axios.post(`/api/stories/${slug}/bookmark`)
				 .then(function(response){
					 let status = response.data.status
					 switch(status) {
						 case 'Bookmarked':
							 icon.classList.add('fas')
							 icon.classList.remove('far')
							 break;
						 case 'Unbookmarked':
							 icon.classList.add('far')
							 icon.classList.remove('fas')
							 break;
						 case 'sign_in_first':
						 	 alert('你必須先登入')
						   break;
					 }
				 })
				 .catch(function(error){
					 console.log(error)
				 })
	}
	
	follow(event) {
		event.preventDefault()
		let user = this.followButtonTarget.dataset.user
		let button = this.followButtonTarget
		
    axios.post(`/api/users/${user}/follow`)
         .then(function(response){
					 let status = response.data.status
					 switch(status) {
						 case 'sign_in_first':
							 alert('你必須先登入')
							 break;
						 case 'Follow':
						 	 button.innerHTML = status
						   button.classList.add('follow-button')
							 button.classList.remove('follow-button-solid')
							 break;
						 case 'Following':
						 	 button.innerHTML = status
						   button.classList.add('follow-button-solid')
							 button.classList.remove('follow-button')
							 break;
					 }
         })
         .catch(function(error){
           console.log(error)
         })
  }
}




